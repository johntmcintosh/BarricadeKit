Pod::Spec.new do |s|
  s.name         = "BarricadeKit"
  s.version      = "1.0.0"
  s.summary      = "Framework for setting up a run-time configurable local server in iOS apps."
  s.homepage     = "https://github.com/johntmcintosh/BarricadeKit"
  s.author       = 'John T McIntosh'
  s.license      = "MIT"

  s.ios.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/johntmcintosh/BarricadeKit.git", :tag => s.version.to_s }
  s.frameworks = 'Foundation', 'CFNetwork'
  s.requires_arc = true
  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.source_files = "BarricadeKit/Core/**/*.{swift}"
    core.exclude_files = "BarricadeKit/Core/**/*Tests.swift"
  end  
end
