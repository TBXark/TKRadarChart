//
//  TKRadarChart.swift
//  TKRadarChart
//
//  Created by Tbxark on 16/7/13.
//  Copyright © 2016年 Tbxark. All rights reserved.
//

import UIKit

/// You can set data chart by `TKRadarChartDataSource`
protocol TKRadarChartDataSource: class {
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int
    
    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat
}

/// You can custom chart by `TKRadarChartDelegate`
protocol TKRadarChartDelegate: class {
    
    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor
   
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor

    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont
}


protocol TKRadarChartDelegateDefault: TKRadarChartDelegate {
}

extension TKRadarChartDelegateDefault {
    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return UIFont.systemFont(ofSize: 11)
    }
    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor.darkGray
    }
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor.lightGray
    }
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        return UIColor.white
    }
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        return UIColor(red:1,  green:0.7,  blue:0.3, alpha:0.5)
    }
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        return UIColor(red:1,  green:0.7,  blue:0.3, alpha:1)
    }

}

///Configuration
struct TKRadarChartConfig {
    
    static func defaultConfig() -> TKRadarChartConfig {
        return TKRadarChartConfig(radius: 80,
                                minValue: 0,
                                maxValue: 5,
                               showPoint: true,
                              showBorder: true,
                                fillArea: true,
                               clockwise: false,
                         autoCenterPoint: true)
    }
    
    
    var radius: CGFloat    // 半径
    var minValue: CGFloat  // 最小值
    var maxValue: CGFloat  // 最大值
    
    var showPoint: Bool  // 显示圆点
    var showBorder: Bool // 显示边界
    var fillArea: Bool   // 填充
    var clockwise: Bool  // 顺时针
    var autoCenterPoint: Bool // 自动设置中心点位置
    
}



class TKRadarChart: UIView, TKRadarChartDelegateDefault {
    
    var centerPoint: CGPoint
    var configuration: TKRadarChartConfig {
        didSet {
            reloadData()
        }
    }
    
    override var frame: CGRect {
        didSet {
            if configuration.autoCenterPoint {
                centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
            }
            if min(frame.width, frame.height) < configuration.radius * 2 {
                configuration.radius = min(frame.width, frame.height)/2 
            }
            setNeedsDisplay()
        }
    }
    
    
    weak var dataSource: TKRadarChartDataSource? 
    weak var delegate: TKRadarChartDelegate?
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, config: TKRadarChartConfig.defaultConfig())
    }
    
    init(frame: CGRect, config: TKRadarChartConfig) {
        centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
        configuration = config
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        centerPoint = CGPoint.zero
        configuration = TKRadarChartConfig.defaultConfig()
        super.init(coder: aDecoder)
        centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
        backgroundColor = UIColor.clear
    }
    
    
    func reloadData() {
        setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        
        guard let dataSource = dataSource,
            let context = UIGraphicsGetCurrentContext()  else { return }

        let delegate =  self.delegate ?? self
        
        
        let textFont = delegate.fontOfTitleForRadarChart(self)
        let numOfSetp = max(dataSource.numberOfStepForRadarChart(self), 1)
        let numOfRow = dataSource.numberOfRowForRadarChart(self)
        let numOfSection = dataSource.numberOfSectionForRadarChart(self)
        let perAngle = CGFloat(M_PI * 2) / CGFloat(numOfRow) * CGFloat(configuration.clockwise ? 1 : -1)
        let padding = CGFloat(2)
        let height = textFont.lineHeight
        let radius = configuration.radius
        let minValue = configuration.minValue
        let maxValue = configuration.maxValue
        
        let lineColor = delegate.colorOfLineForRadarChart(self)
        
        /// Create  titles
        let titleColor = delegate.colorOfTitleForRadarChart(self)
        for index in 0..<numOfRow {
            let i = CGFloat(index)
            let title = dataSource.titleOfRowForRadarChart(self, row: index)
            let pointOnEdge = CGPoint(x: centerPoint.x - radius * sin(i * perAngle),
                                      y: centerPoint.y - radius * cos(i * perAngle))
            let attributeTextSize = (title as NSString).size(attributes: [NSFontAttributeName: textFont])
            
            let width = attributeTextSize.width
            let xOffset = pointOnEdge.x >=  centerPoint .x ? width / 2.0 + padding : -width / 2.0 - padding
            let yOffset = pointOnEdge.y >=  centerPoint .y ? height / 2.0 + padding : -height / 2.0 - padding
            var legendCenter = CGPoint(x: pointOnEdge.x + xOffset, y: pointOnEdge.y + yOffset)
            
            let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byClipping
            let attributes = [NSFontAttributeName: textFont,
                              NSParagraphStyleAttributeName: paragraphStyle,
                              NSForegroundColorAttributeName: titleColor]
            
            /// Fix title offset
            if index == 0 ||  (numOfRow%2 == 0 && index == numOfRow/2){
                legendCenter.x = centerPoint.x
                legendCenter.y = centerPoint.y + (radius + padding + height / 2.0) * CGFloat(index == 0 ? -1 : 1)
            }
            let rect = CGRect(x: legendCenter.x - width / 2.0, y: legendCenter.y - height / 2.0, width: width, height: height)
            (title as NSString).draw(in: rect, withAttributes: attributes)
        }
        
        
        /// Draw the background rectangle
        context.saveGState()
        lineColor.setStroke()
        for stepTemp in 1...numOfSetp {
            let step = numOfSetp - stepTemp + 1
            let fillColor = delegate.colorOfFillStepForRadarChart(self, step: step)
           
            let scale = CGFloat(step)/CGFloat(numOfSetp)
            let innserRadius = scale * radius
            let path = UIBezierPath()
            for index in 0..<numOfRow {
                let i = CGFloat(index)
                if index == 0 {
                    let x = centerPoint.x
                    let y = centerPoint.y -  innserRadius
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    let x = centerPoint.x - innserRadius * sin(i * perAngle)
                    let y = centerPoint.y - innserRadius * cos(i * perAngle)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            let x = centerPoint.x
            let y = centerPoint.y - innserRadius
            path.addLine(to: CGPoint(x: x, y: y))
            
            
            fillColor.setFill()
            
            path.lineWidth = 1
            path.fill()
            path.stroke()
        }
        context.restoreGState()
        
        
        /// Draw the background line
        lineColor.setStroke()
        for index in 0..<numOfRow {
            let i = CGFloat(index)
            let path = UIBezierPath()
            path.move(to: centerPoint)
            let x = centerPoint.x - radius * sin(i * perAngle)
            let y = centerPoint.y - radius * cos(i * perAngle)
            path.addLine(to: CGPoint(x: x, y: y))
            path.stroke()
        }
        
        
        
        /// Draw section
        if numOfRow > 0 {
            for section in 0..<numOfSection {
                
                let fillColor = delegate.colorOfSectionFillForRadarChart(self, section: section)
                let borderColor = delegate.colorOfSectionBorderForRadarChart(self, section: section)
                
                let path = UIBezierPath()
                for index in 0..<numOfRow {
                    let i = CGFloat(index)
                    let value = dataSource.valueOfSectionForRadarChart(withRow: index, section: section)
                    let scale = (value - minValue)/(maxValue - minValue)
                    let innserRadius = scale * radius
                    if index == 0 {
                        let x = centerPoint.x
                        let y = centerPoint.y -  innserRadius
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        let x = centerPoint.x - innserRadius * sin(i * perAngle)
                        let y = centerPoint.y - innserRadius * cos(i * perAngle)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                
                let value = dataSource.valueOfSectionForRadarChart(withRow: 0, section: section)
                let x = centerPoint.x
                let y = centerPoint.y - (value - minValue) / (maxValue - minValue) * radius
                path.addLine(to: CGPoint(x: x, y: y))
                
                
                fillColor.setFill()
                borderColor.setStroke()
                
                path.lineWidth = 2
                if configuration.showBorder {
                    path.stroke()
                }
                if configuration.fillArea {
                    path.fill()
                }
                
                // Draw point
                if configuration.showPoint {
                    let borderColor = delegate.colorOfSectionBorderForRadarChart(self, section: section)
                    for i in 0..<numOfRow {
                        let value = dataSource.valueOfSectionForRadarChart(withRow: i, section: section)
                        let xVal = centerPoint.x - (value - minValue) / (maxValue - minValue) * radius * sin(CGFloat(i) * perAngle)
                        let yVal = centerPoint.y - (value - minValue) / (maxValue - minValue) * radius * cos(CGFloat(i) * perAngle)
                        borderColor.setFill()
                        context.fillEllipse(in: CGRect(x: xVal-3, y: yVal-3, width: 6, height: 6))
                    }
                }
            }
        }
    }
}
