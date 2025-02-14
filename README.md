![](https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/Assets/EFAutoScrollLabel.png)

<p align="center">
    <a href="https://swiftpackageindex.com/EFPrefix/EFAutoScrollLabel">
        <img src="https://img.shields.io/badge/SPM-ready-orange.svg">
    </a>
    <a href="http://cocoapods.org/pods/EFAutoScrollLabel">
    	<img src="https://img.shields.io/cocoapods/v/EFAutoScrollLabel.svg?style=flat">
    </a>
    <a href="http://cocoapods.org/pods/EFAutoScrollLabel">
    	<img src="https://img.shields.io/cocoapods/p/EFAutoScrollLabel.svg?style=flat">
    </a>
    <a href="https://github.com/apple/swift">
    	<img src="https://img.shields.io/badge/language-swift-orange.svg">
    </a>
    <a href="https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/LICENSE">
    	<img src="https://img.shields.io/cocoapods/l/EFAutoScrollLabel.svg?style=flat">
    </a>
</p>

A label which can scroll when text length beyond the width of label, in Swift. Converted from [AutoScrollLabel](https://github.com/firewolf-ljw/AutoScrollLabel/commit/6981994ad64ab3b29b87a423109f556134c83b41)

> [中文介绍](https://github.com/EFPrefix/EFAutoScrollLabel/blob/master/README_CN.md)

## Overview

<img src="https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/Assets/example.gif" width = "62.5%"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 16+
- Swift 6.0+

## Installation

### CocoaPods

EFAutoScrollLabel is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "EFAutoScrollLabel"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

Once you have your Swift package set up, adding EFAutoScrollLabel as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/EFPrefix/EFAutoScrollLabel.git", .upToNextMinor(from: "6.0.0.0"))
]
```

## Setup

Simply initialize a `EFAutoScrollLabel` the same way you set up a regular `UILabel`:

```swift
let myLabel = EFAutoScrollLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
self.view.addSubview(myLabel)
```

## Use

#### 1. Import EFAutoScrollLabel module where you want to use it:

```swift
import EFAutoScrollLabel
```

#### 2. Initialize a `EFAutoScrollLabel` and set some parameter:

```swift
let myLabel = EFAutoScrollLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
myLabel.backgroundColor = UIColor(red: 253.0 / 255.0, green: 255.0 / 255.0, blue: 234.0 / 255.0, alpha: 1)
myLabel.textColor = UIColor(red: 249.0 / 255.0, green: 94.0 / 255.0, blue: 22.0 / 255.0, alpha: 1)
myLabel.font = UIFont.systemFont(ofSize: 13)
myLabel.labelSpacing = 30                       // Distance between start and end labels
myLabel.pauseInterval = 1.7                     // Seconds of pause before scrolling starts again
myLabel.scrollSpeed = 30                        // Pixels per second
myLabel.textAlignment = NSTextAlignment.left    // Centers text when no auto-scrolling is applied
myLabel.fadeLength = 12                         // Length of the left and right edge fade, 0 to disable
myLabel.scrollDirection = EFAutoScrollDirection.left
self.view.addSubview(myLabel)
```

#### 3. `AutoLayout` is also supported.

## Author

EyreFree, eyrefree@eyrefree.org

## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFAutoScrollLabel is available under the MIT license. See the LICENSE file for more info.
