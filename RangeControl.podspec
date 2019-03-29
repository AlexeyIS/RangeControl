Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '12.0'
  s.name         = "RangeControl"
  s.version      = "0.0.1"
  s.summary      = "RangeControl lets user to trim from both ends. "

  s.description  = "RangeControl lets user to trim from both ends. "

  s.homepage     = "http://EXAMPLE/RangeControl"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author = { "Alexey Ledovskiy" => "alexey.ledovskiy@gmail.com" }
  s.social_media_url   = "http://twitter.com/AlexeyIS"

  s.source = { :git => "https://github.com/AlexeyIS/RangeControl.git", :tag => "#{s.version}" }


  s.source_files = "RangeControl/**/*.{swift}"
  s.framework = "UIKit"

end
