//
//  ViewController.swift
//  TKRadarChartDemo
//
//  Created by Tbxark on 27/11/2016.
//  Copyright © 2016 Tbxark. All rights reserved.
//

import UIKit
import TKRadarChart

class ViewController: UIViewController, TKRadarChartDataSource, TKRadarChartDelegate, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = view.bounds.width
        let chart = TKRadarChart(frame: CGRect(x: 0, y: 0, width: w, height: w))
        chart.configuration.radius = w/3
        chart.dataSource = self
        chart.delegate = self
        chart.center = view.center
        chart.reloadData()
        view.addSubview(chart)
    }
    
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 5
    }
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 6
    }
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int {
        return 2
    }
    
    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String {
        return "NO.\(row + 1)"
    }
    
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(max(min(row + 1, 4), 3))
        } else {
            return 3
        }
    }
    
    
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor {
        return UIColor(red:0.337,  green:0.847,  blue:0.976, alpha:1)
    }
    
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor {
        switch step {
        case 1:
            return UIColor(red:0.545,  green:0.906,  blue:0.996, alpha:1)
        case 2:
            return UIColor(red:0.706,  green:0.929,  blue:0.988, alpha:1)
        case 3:
            return UIColor(red:0.831,  green:0.949,  blue:0.984, alpha:1)
        case 4:
            return UIColor(red:0.922,  green:0.976,  blue:0.988, alpha:1)
        default:
            return UIColor.white
        }
    }
    
    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return UIColor(red:1,  green:0.867,  blue:0.012, alpha:0.4)
        } else {
            return UIColor(red:0,  green:0.788,  blue:0.543, alpha:0.4)
        }
    }
    
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor {
        if section == 0 {
            return UIColor(red:1,  green:0.867,  blue:0.012, alpha:1)
        } else {
            return UIColor(red:0,  green:0.788,  blue:0.543, alpha:1)
        }
    }
    
    func fontOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    
    
}
