//
//  TKRadarChart.swift
//  TKRadarChart
//
//  Created by Tbxark on 16/7/13.
//  Copyright © 2016年 Tbxark. All rights reserved.
//

import UIKit

#if swift( >=4.2)
typealias NSAttributedStringKey = NSAttributedString.Key
#endif



/// You can set data chart by `TKRadarChartDataSource`
public protocol TKRadarChartDataSource: class {
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int
    
    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat
}

/// You can custom chart by `TKRadarChartDelegate`
public protocol TKRadarChartDelegate: class {
    
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor
    
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor
    
    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont
    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor

}


extension TKRadarChartDelegate {
    public func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return UIFont.boldSystemFont(ofSize: 12)
    }
    public func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor.gray
    }
    
    public func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor(red:0.937,  green:0.925,  blue:0.902, alpha:1)
    }
    
    public func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        return UIColor.clear
    }
    
    public func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        return UIColor(red:0.561,  green:0.753,  blue:0.996, alpha:0.6)
    }
    
    public func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        return UIColor(red:1,  green:0.867,  blue:0.012, alpha:1)
    }
    

}

///Configuration
public struct TKRadarChartConfig {
    
    public static func defaultConfig() -> TKRadarChartConfig {
        return TKRadarChartConfig(radius: 80,
                                  minValue: 0,
                                  maxValue: 5,
                                  borderWidth: 4,
                                  lindWidth: 1,
                                  showPoint: false,
                                  showBorder: false,
                                  showBgLine: true,
                                  showBgBorder: true,
                                  fillArea: true,
                                  clockwise: false,
                                  autoCenterPoint: true)
    }
    
    
    public var radius: CGFloat
    public var minValue: CGFloat
    public var maxValue: CGFloat
    
    public var borderWidth: CGFloat
    public var lindWidth: CGFloat
    
    public var showPoint: Bool
    public var showBorder: Bool
    public var showBgLine: Bool
    public var showBgBorder: Bool
    public var fillArea: Bool
    public var clockwise: Bool
    public var autoCenterPoint: Bool
    
    
    public init(radius: CGFloat,
                minValue: CGFloat,
                maxValue: CGFloat,
                borderWidth: CGFloat,
                lindWidth: CGFloat,
                showPoint: Bool,
                showBorder: Bool,
                showBgLine: Bool,
                showBgBorder: Bool,
                fillArea: Bool,
                clockwise: Bool,
                autoCenterPoint: Bool) {
        self.radius = radius
        self.minValue = minValue
        self.maxValue = maxValue
        self.borderWidth = borderWidth
        self.lindWidth = lindWidth
        self.showPoint = showPoint
        self.showBorder = showBorder
        self.showBgLine = showBgLine
        self.showBgBorder = showBgBorder
        self.fillArea = fillArea
        self.clockwise = clockwise
        self.autoCenterPoint = autoCenterPoint
    }
}



public class TKRadarChart: UIView, TKRadarChartDelegate {
    
    public var centerPoint: CGPoint
    public var configuration: TKRadarChartConfig {
        didSet {
            reloadData()
        }
    }
    
    public override var frame: CGRect {
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
    
    
    public weak var dataSource: TKRadarChartDataSource?
    public weak var delegate: TKRadarChartDelegate?
    
    public override convenience init(frame: CGRect) {
        self.init(frame: frame, config: TKRadarChartConfig.defaultConfig())
    }
    
    public init(frame: CGRect, config: TKRadarChartConfig) {
        centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
        configuration = config
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        centerPoint = CGPoint.zero
        configuration = TKRadarChartConfig.defaultConfig()
        super.init(coder: aDecoder)
        centerPoint = CGPoint(x: frame.width/2, y: frame.height/2)
        backgroundColor = UIColor.clear
    }
    
    
    public func reloadData() {
        setNeedsDisplay()
    }
    
    
    public override func draw(_ rect: CGRect) {
        
        guard let dataSource = dataSource,
            let context = UIGraphicsGetCurrentContext()  else { return }
        
        
        let delegate =  self.delegate ?? self
        let numOfRow = dataSource.numberOfRowForRadarChart(self)
        
        guard numOfRow > 0 else { return }
        
        let textFont = delegate.fontOfTitleForRadarChart(self)
        let numOfSetp = max(dataSource.numberOfStepForRadarChart(self), 1)
        let numOfSection = dataSource.numberOfSectionForRadarChart(self)
        let perAngle = CGFloat.pi * 2 / CGFloat(numOfRow) * CGFloat(configuration.clockwise ? 1 : -1)
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
            let attributeTextSize = (title as NSString).size(withAttributes: [NSAttributedStringKey.font: textFont])
            
            let width = attributeTextSize.width
            let xOffset = pointOnEdge.x >=  centerPoint .x ? width / 2.0 + padding : -width / 2.0 - padding
            let yOffset = pointOnEdge.y >=  centerPoint .y ? height / 2.0 + padding : -height / 2.0 - padding
            var legendCenter = CGPoint(x: pointOnEdge.x + xOffset, y: pointOnEdge.y + yOffset)
            
            let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byClipping
            let attributes = [NSAttributedStringKey.font: textFont,
                              NSAttributedStringKey.paragraphStyle: paragraphStyle,
                              NSAttributedStringKey.foregroundColor: titleColor]
            
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
            for index in 0...numOfRow {
                let i = CGFloat(index)
                if index == 0 {
                    let x = centerPoint.x
                    let y = centerPoint.y -  innserRadius
                    path.move(to: CGPoint(x: x, y: y))
                } else if index == numOfRow {
                    let x = centerPoint.x
                    let y = centerPoint.y - innserRadius
                    path.addLine(to: CGPoint(x: x, y: y))
                }else {
                    let x = centerPoint.x - innserRadius * sin(i * perAngle)
                    let y = centerPoint.y - innserRadius * cos(i * perAngle)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            path.close()
            fillColor.setFill()
            
            path.lineWidth = configuration.borderWidth
            path.fill()
            if configuration.showBgBorder {
                path.stroke()
            }
        }
        context.restoreGState()
        
        
        /// Draw the background line
        lineColor.setStroke()
        if configuration.showBgLine {
            for index in 0..<numOfRow {
                let i = CGFloat(index)
                let path = UIBezierPath()
                path.move(to: centerPoint)
                let x = centerPoint.x - radius * sin(i * perAngle)
                let y = centerPoint.y - radius * cos(i * perAngle)
                path.addLine(to: CGPoint(x: x, y: y))
                path.lineWidth = configuration.lindWidth
                path.stroke()
            }
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
                if configuration.fillArea {
                    path.fill()
                }
                if configuration.showBorder {
                    path.stroke()
                }
                
                // Draw point
                if configuration.showPoint {
                    let borderColor = delegate.colorOfSectionBorderForRadarChart(self, section: section)
                    for i in 0..<numOfRow {
                        let value = dataSource.valueOfSectionForRadarChart(withRow: i, section: section)
                        let xt = radius * sin(CGFloat(i) * perAngle)
                        let yt = radius * cos(CGFloat(i) * perAngle)
                        let xVal = centerPoint.x - (value - minValue) / (maxValue - minValue) * xt
                        let yVal = centerPoint.y - (value - minValue) / (maxValue - minValue) * yt
                        borderColor.setFill()
                        context.fillEllipse(in: CGRect(x: xVal-3, y: yVal-3, width: 6, height: 6))
                    }
                }
            }
        }
    }
}
