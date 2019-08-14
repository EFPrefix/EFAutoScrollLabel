![](https://raw.githubusercontent.com/EFPrefix/EFAutoScrollLabel/master/Assets/EFAutoScrollLabel.png)

<p align="center">
    <a href="https://travis-ci.org/EFPrefix/EFAutoScrollLabel">
    	<img src="http://img.shields.io/travis/EFPrefix/EFAutoScrollLabel.svg">
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
    <a href="https://twitter.com/EyreFree777">
    	<img src="https://img.shields.io/badge/twitter-@EyreFree777-blue.svg?style=flat">
    </a>
    <a href="http://weibo.com/eyrefree777">
    	<img src="https://img.shields.io/badge/weibo-@EyreFree-red.svg?style=flat">
    </a>
    <img src="https://img.shields.io/badge/made%20with-%3C3-orange.svg">
    <a href="http://shang.qq.com/wpa/qunwpa?idkey=d0f732585dcb0c6f2eb26bc9e0327f6305d18260eeba89ed26a201b520c572c0">
        <img src="https://img.shields.io/badge/Q群-769966374-32befc.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAQCAMAAAARSr4IAAAA4VBMVEUAAAAAAAAAAAD3rwgAAAAAAADpICBuTQNUDAwAAAAAAAAAAAAAAADnICAAAAAAAACbFRUAAAD5rgkfFgEAAADHGxu1GBhGOyQ6LhMPCgAAAAB0UQRbDAziHh7hHh5HRUEAAAAPAgIQCwEQEBAdBAQgICAvIQIvLy8+LAJAQEBJCgpWRBpbW1tfX19gYGBqZVptTARvb299VwSAgICEhISHh4ePhnGbbAWgoKCseAawsLC7gwbAwMDExMTFrKzLjgfoHx/powfqpAjvZGTw8PDxcnLxenrzj4/5rgj5x8f///9y6ONcAAAAIHRSTlMAECAgMEBQVlhggZGhobHBwdHR3eHh4+fp7/Hx9/f5+3tefS0AAACkSURBVHjaNc1FAsJAEAXRDj64BAv2IbgEd2s0gfsfiJkAtXurIpkWMQBd0K8O3KZfhWEeW9YB8LnUYY2Gi6WJqJIHwKo7GAMpRT/aV0d2BhRD/Xp7tt9OGs2yYoy5mpUxc0BOc/yvkiQSwJPZtu3XCdAoDtjMb5k8C9KN1utx+zFChsD97bYzRII0Ss2/7IUliILFjZKV8ZLM61xK+V6tsHbSRB+BYB6Vhuib7wAAAABJRU5ErkJggg==">
    </a>
</p>

UILabel 跑马灯效果, Swift 版。

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

| 版本    | 需求                                                            |
|:--------|:------------------------------------------------|
| 1.x      | XCode 8.0+<br>Swift 3.0+<br>iOS 8.0+   |
| 4.x      | XCode 9.0+<br>Swift 4.0+<br>iOS 8.0+   |
| 5.x      | XCode 10.2+<br>Swift 5.0+<br>iOS 8.0+ |

## 导入

EFAutoScrollLabel 可以通过 [CocoaPods](http://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```
pod "EFAutoScrollLabel"
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

## 备注

[EFAutoScrollLabel](https://github.com/EFPrefix/EFAutoScrollLabel) 是基于 [AutoScrollLabel](https://github.com/firewolf-ljw/AutoScrollLabel/commit/6981994ad64ab3b29b87a423109f556134c83b41) 进行开发的。

## 使用 EFColorPicker 的应用

<table>
    <tr>
        <td>
            <a href='https://www.appsight.io/app/oneplace-com' title='OnePlace - Christian Audio Broadcasts &amp; S'>
                <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/000/131/320/media/small.png?1475577461'>
            </a>
        </td>
    </tr>
</table>

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFAutoScrollLabel 基于 MIT 协议进行分发和使用，更多信息参见协议文件。
