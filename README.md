# TKRadarChart
> A customizable radar chart in Swift

![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
[![Build Status](https://travis-ci.org/TBXark/TKRadarChart.svg?branch=master)](https://travis-ci.org/TBXark/TKRadarChart)
[![CocoaPods](http://img.shields.io/cocoapods/v/TKRadarChart.svg?style=flat)](http://cocoapods.org/?q=TKRadarChart)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/TBXark/TKRadarChart/master/LICENSE)


![](DemoImage/example.png)

## Requirements

- iOS 11.0+
- Xcode 12.0
- Swift 5.0

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `TKRadarChart` by adding it to your `Podfile`:

```ruby
platform :ios, '11.0'
use_frameworks!
pod 'TKRadarChart'
```

To get the full benefits import `TKRadarChart` wherever you import UIKit

``` swift
import UIKit
import TKRadarChart
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/TKRadarChart.framework` to an iOS project.

```ruby
github "tbxark/TKRadarChart"
```

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.
Once you have your Swift package set up, adding TKRadarChart as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/pabloruan0710/TKRadarChart", .upToNextMajor(from: "1.4.3"))
]
```
#### Manually
1. Download and drop ```TKRadarChart.swift``` in your project.  
2. Congratulations!  

## Usage example

### Base

|Base|Description|Demo|
|---|---|---|
|Step|Background polygon laps(min 1)|![image](Sources/DemoImage/origin.png) ![image](Sources/DemoImage/step.png)|
|Row|Number of edges of polygon (min 3)|![image](Sources/DemoImage/origin.png) ![image](Sources/DemoImage/row.png)|
|Section|At the same time show the number of data|![image](Sources/DemoImage/origin.png) ![image](Sources/DemoImage/section.png)|

### TKRadarChartConfig

This structure is used for custom charts

```swift
    var radius: CGFloat    
    var minValue: CGFloat
    var maxValue: CGFloat

    var showPoint: Bool
    var showBorder: Bool
    var fillArea: Bool
    var clockwise: Bool
    var autoCenterPoint: Bool
```

### TKRadarChartDataSource

This protocol represents the data model object. as such, it supplies no information about appearance

```swift
protocol TKRadarChartDataSource: class {
    func numberOfStepForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfRowForRadarChart(_ radarChart: TKRadarChart) -> Int
    func numberOfSectionForRadarChart(_ radarChart: TKRadarChart) -> Int

    func titleOfRowForRadarChart(_ radarChart: TKRadarChart, row: Int) -> String
    func valueOfSectionForRadarChart(withRow row: Int, section: Int) -> CGFloat
}
```

### TKRadarChartDelegate

This represents the display and behaviour of the TKRadarChart.

```swift
protocol TKRadarChartDelegate: class {
    func colorOfTitleForRadarChart(_ radarChart: TKRadarChart) -> UIColor
    func colorOfLineForRadarChart(_ radarChart: TKRadarChart) -> UIColor
    func colorOfFillStepForRadarChart(_ radarChart: TKRadarChart, step: Int) -> UIColor

    func colorOfSectionFillForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor
    func colorOfSectionBorderForRadarChart(_ radarChart: TKRadarChart, section: Int) -> UIColor
}
```


## Release History
* 1.4.4 
  Upgrade to swift 5.0
  Support SPM

* 1.4.3 
  Upgrade to swift 4.2

* 1.4.2
  Fix bugs that can not change the title font

* 1.4.1 
  Fix warnign

* 1.4.0
  Upgrade to swift 4.0

* 1.3.1
  Upgrade framework config
    
* 1.3.0
  Support swift 3.0

* 1.0.1
  Complete basic functions, add Cocoapod and Carthage support

## Contribute

We would love for you to contribute to **TKRadarChart**, check the ``LICENSE`` file for more info.

## Meta

TBXark – [@tbxark](https://twitter.com/tbxark) – tbxark@outlook.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/TBXark](https://github.com/TBXark)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
