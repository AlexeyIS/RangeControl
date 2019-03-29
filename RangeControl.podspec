Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  
  s.name         = "RangeControl"
  s.version      = "0.0.3"
  s.summary      = "RangeControl lets user to trim from both ends."

  s.description  = "RangeControl allows to select range values from min to max range."

  s.homepage     = "https://github.com/AlexeyIS/RangeControl"
  s.screenshots  = "https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot1.png", "https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot2.gif", "https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot3.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author = { "Alexey Ledovskiy" => "alexey.ledovskiy@gmail.com" }
  s.social_media_url   = "http://twitter.com/AlexeyIS"

  s.source = { :git => "https://github.com/AlexeyIS/RangeControl.git", :tag => "#{s.version}" }


  s.source_files = "RangeControl/**/*.{swift}"
  s.framework = "UIKit"
  s.swift_version = "4.2"

end
