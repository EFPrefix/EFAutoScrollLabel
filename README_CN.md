# EFAutoScrollLabel

[![CI Status](http://img.shields.io/travis/EyreFree/EFAutoScrollLabel.svg?style=flat)](https://travis-ci.org/EyreFree/EFAutoScrollLabel)
[![Version](https://img.shields.io/cocoapods/v/EFAutoScrollLabel.svg?style=flat)](http://cocoapods.org/pods/EFAutoScrollLabel)
[![License](https://img.shields.io/cocoapods/l/EFAutoScrollLabel.svg?style=flat)](http://cocoapods.org/pods/EFAutoScrollLabel)
[![Platform](https://img.shields.io/cocoapods/p/EFAutoScrollLabel.svg?style=flat)](http://cocoapods.org/pods/EFAutoScrollLabel)
[![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://travis-ci.org/EyreFree/EFAutoScrollLabel)

UILabel 跑马灯效果, Swift 版。

> [English Introduction](https://github.com/EyreFree/EFAutoScrollLabel/blob/master/README.md)

## 概述

<img src="EFAutoScrollLabel/Assets/example.gif" width = "62.5%"/>

## 示例

1. 利用 `git clone` 命令下载本仓库；
2. 利用 cd 命令切换到 Example 目录下，执行 `pod install` 命令；
3. 随后打开 `EFAutoScrollLabel.xcworkspace` 编译即可。

或执行以下命令：

```bash
git clone git@github.com:EyreFree/EFAutoScrollLabel.git; cd EFAutoScrollLabel/Example; pod install; open EFAutoScrollLabel.xcworkspace
```

## 环境

- XCode 8.0+
- Swift 3.0+

## 导入

EFAutoScrollLabel 可以通过 [CocoaPods](http://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```
pod "EFAutoScrollLabel", '~> 1.0.0'
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
myLabel.observeApplicationNotifications()
self.view.addSubview(myLabel)
```

#### 3. 支持 `AutoLayout`。

## 备注

[EFAutoScrollLabel](https://github.com/EyreFree/EFAutoScrollLabel) 是基于 [AutoScrollLabel](https://github.com/firewolf-ljw/AutoScrollLabel/commit/6981994ad64ab3b29b87a423109f556134c83b41) 进行开发的。

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

EFAutoScrollLabel 基于 MIT 协议进行分发和使用，更多信息参见协议文件。
