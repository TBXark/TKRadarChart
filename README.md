# 中文

TKRadarChart 是一个简单的可定制的雷达图

### CocoaPods
```
  pod 'TKRadarChart',
```

### Base

|基本概念|描述|演示|
|---|---|---|
|Step|背景多边形圈数, 最小值为1|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/step.png?raw=true)|
|Row|多边形边数, 最小值为三|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/row.png?raw=true)|
|Section|同时展现数据组数|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/section.png?raw=true)|


### TKRadarChartDataSource

通过 TKRadarChartDataSource 可以对 RadarChart 的 row,section,setp 进行设置, 并且获取每个 Section 的数据进行绘制

```
    func numberOfStepForRadarChart(radarChart: TKRadarChart) -> Int
    func numberOfRowForRadarChart(radarChart: TKRadarChart) -> Int
    func numberOfSectionForRadarChart(radarChart: TKRadarChart) -> Int
    
    func titleOfRowForRadarChart(radarChart: TKRadarChart, row: Int) -> String
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat

```
### TKRadarChartDelegate

通过 TKRadarChartDelegate 可以对 RadarChart 的 UI 进行定制

```

	func fontOfTitleForRadarChart(radarChart: TKRadarChart) -> UIFont
	func colorOfTitleForRadarChart(radarChart: TKRadarChart) -> UIColor
	
    func colorOfTitleForRadarChart(radarChart: TKRadarChart) -> UIColor
    func colorOfLineForRadarChart(radarChart: TKRadarChart) -> UIColor
    func colorOfFillStepForRadarChart(radarChart: TKRadarChart, step: Int) -> UIColor
   
    func colorOfSectionFillForRadarChart(radarChart: TKRadarChart, section: Int) -> UIColor
    func colorOfSectionBorderForRadarChart(radarChart: TKRadarChart, section: Int) -> UIColor

```

### TKRadarChartConfig 

属性 configuretion 中是一下雷达图的必要属性,通过 设置 configuretion 属性可以快速的刷新雷达图

```
    var radius: CGFloat    
    var minValue: CGFloat
    var maxValue: CGFloat
    
    var showPoint: Bool
    var showBorder: Bool
    var fillArea: Bool
    var clockwise: Bool
    var autoCenterPoint: Bool


```

----


# TKRadarChart
A customizable radar chart 

### CocoaPods
```
  pod 'TKRadarChart',
```

### Base

|Base|Description|Demo|
|---|---|---|
|Step|Background polygon laps(min 1)|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/step.png?raw=true)|
|Row|Polygon number of edges (min 3)|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/row.png?raw=true)|
|Section|Show the number of sets of data|![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/origin.png?raw=true) ![image](https://github.com/TBXark/TKRadarChart/blob/master/DemoImage/section.png?raw=true)|


### TKRadarChartDataSource

Implementation TKRadarChartDataSource to set row, section, setp set for radar chart, and render each section 

```
    func numberOfStepForRadarChart(radarChart: TKRadarChart) -> Int
    func numberOfRowForRadarChart(radarChart: TKRadarChart) -> Int
    func numberOfSectionForRadarChart(radarChart: TKRadarChart) -> Int
    
    func titleOfRowForRadarChart(radarChart: TKRadarChart, row: Int) -> String
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat

```
### TKRadarChartDelegate

Implementation TKRadarChartDelegate can be customized RadarChart UI 

```

	func fontOfTitleForRadarChart(radarChart: TKRadarChart) -> UIFont
	func colorOfTitleForRadarChart(radarChart: TKRadarChart) -> UIColor
	
    func colorOfTitleForRadarChart(radarChart: TKRadarChart) -> UIColor
    func colorOfLineForRadarChart(radarChart: TKRadarChart) -> UIColor
    func colorOfFillStepForRadarChart(radarChart: TKRadarChart, step: Int) -> UIColor
   
    func colorOfSectionFillForRadarChart(radarChart: TKRadarChart, section: Int) -> UIColor
    func colorOfSectionBorderForRadarChart(radarChart: TKRadarChart, section: Int) -> UIColor

```

### TKRadarChartConfig 
`configuretion` is  necessary property, by setting the configuretion property can quickly reload radar chart
```
    var radius: CGFloat    
    var minValue: CGFloat
    var maxValue: CGFloat
    
    var showPoint: Bool
    var showBorder: Bool
    var fillArea: Bool
    var clockwise: Bool
    var autoCenterPoint: Bool


```
