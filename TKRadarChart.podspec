Pod::Spec.new do |s|
  s.name         = "TKRadarChart"
  s.version      = "1.4.4"
  s.summary      = "TKRadarChart is a customizable radar chart  "
  s.license      = { :type => 'MIT License', :file => 'LICENSE' }
  s.homepage     = "https://github.com/TBXark/TKRadarChart"
  s.author       = { "TBXark" => "https://github.com/TBXark" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/TBXark/TKRadarChart.git", :tag => s.version }
  s.source_files  = "Sources/TKRadarChart/TKRadarChart.swift"
  s.requires_arc = true
end
