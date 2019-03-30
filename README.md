# RangeControl

RangeControl is a UIControl element that allows to select control range from min to max values. 

[![ScreenShot](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot1.png "ScreenShot")](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot1.png "ScreenShot")

[![Screenshoot](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot2.gif "Screenshoot")](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot2.gif "Screenshoot")


## Getting Started

You can setup RangeControl from code or from storyboard. It also allows you to add custom view to the background. 

```swift
let imageView = UIImageView(image: UIImage(named: "testImage"))
imageView.contentMode = .scaleAspectFill
imageView.translatesAutoresizingMaskIntoConstraints = false
imageView.clipsToBounds = true
rangeControl.backgroundView.addArrangedSubview(imageView)
```
You can add block to listen for values update: 
```
rangeControl.onRangeValueChanged = { (low,up) in
            print("Low: \(low) up: \(up)")
        }
```
### Prerequisites

The demo project is included here RangeControlExample.  

[![screenshot1](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot3.gif "screenshot1")](https://raw.githubusercontent.com/AlexeyIS/RangeControl/master/screenshot3.gif "screenshot1")

## Requirements

- iOS 10.0+
- Xcode 10.1+
- Swift 4.2+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'RangeControl'
```

## Authors

* **Alexey Ledovskiy** - *Initial work* - [RangeControl](https://github.com/AlexeyIS/RangeControl)

## Donations
Any amount you can donate today to support the project would be greatly appreciated.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6WLJ933Z3K7BC)



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
