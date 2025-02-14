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

UILabel 跑马灯效果, Swift 版。基于 [AutoScrollLabel](https://github.com/firewolf-ljw/AutoScrollLabel/commit/6981994ad64ab3b29b87a423109f556134c83b41) 进行开发。

> [English Introduction](https://github.com/EFPrefix/EFAutoScrollLabel/blob/master/README.md)

## 概述

<img src="https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/Assets/example.gif" width = "62.5%"/>

## 示例

1. 利用 `git clone` 命令下载本仓库；
2. 利用 cd 命令切换到 Example 目录下，执行 `pod install` 命令；
3. 随后打开 `EFAutoScrollLabel.xcworkspace` 编译即可。

或执行以下命令：

```bash
git clone git@github.com:EFPrefix/EFAutoScrollLabel.git; cd EFAutoScrollLabel/Example; pod install; open EFAutoScrollLabel.xcworkspace
```

## 环境

- Xcode 16+
- Swift 6.0+

## 导入

### CocoaPods

EFAutoScrollLabel 可以通过 [CocoaPods](http://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```
pod "EFAutoScrollLabel"
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) 是一个集成在 Swift 编译器中的用来进行 Swift 代码自动化发布的工具。

如果你已经建立了你的 Swift 包，将 EFAutoScrollLabel 加入依赖是十分容易的，只需要将其添加到你的 `Package.swift` 文件的 `dependencies` 项中即可：

```swift
dependencies: [
    .package(url: "https://github.com/EFPrefix/EFAutoScrollLabel.git", .upToNextMinor(from: "6.0.0.0"))
]
```

## 建立

`EFAutoScrollLabel` 可以简单地像一个普通的 `UILabel` 一样进行使用：

```swift
let myLabel = EFAutoScrollLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
self.view.addSubview(myLabel)
```

## 使用

#### 1. 在你需要使用的地方添加如下代码引入 EFAutoScrollLabel 模块：

```swift
import EFAutoScrollLabel
```

#### 2. 初始化一个 `EFAutoScrollLabel` 并且设置一些参数：

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
myLabel.scrollDirection = AutoScrollDirection.Left
self.view.addSubview(myLabel)
```

#### 3. 支持 `AutoLayout`。

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFAutoScrollLabel 基于 MIT 协议进行分发和使用，更多信息参见协议文件。
