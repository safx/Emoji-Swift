Pod::Spec.new do |s|
  s.name         = "Emoji-swift"
  s.version      = "0.0.1"
  s.summary      = "String extension for Emoji, written in Swift"
  s.homepage     = "https://github.com/safx/emoji-swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "MATSUMOTO Yuji" => "safxdev@gmail.com" }
  s.source       = { :git => "https://github.com/safx/emoji-swift.git", :tag => s.version }
  s.module_name  = "Emoji"
  s.source_files = "Emoji/*.swift"
  s.framework    = 'Foundation'
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.requires_arc = true
end
