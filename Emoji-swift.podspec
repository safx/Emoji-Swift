Pod::Spec.new do |s|
  s.name         = "Emoji-swift"
  s.version      = "0.3.0"
  s.summary      = "String extension converting to and from emoji character and Emoji Cheat Sheet string"
  s.homepage     = "https://github.com/safx/Emoji-Swift"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "MATSUMOTO Yuji" => "safxdev@gmail.com" }
  s.source       = { :git => "https://github.com/safx/Emoji-Swift.git", :tag => s.version }
  s.module_name  = "Emoji"
  s.source_files = "Sources/*.swift"
  s.framework    = 'Foundation'
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "5.0"
  s.requires_arc = true
end
