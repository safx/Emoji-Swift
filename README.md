# Emoji-Swift

[![TravisCI](http://img.shields.io/travis/safx/Emoji-Swift.svg?style=flat)](https://travis-ci.org/safx/Emoji-Swift)
[![codecov.io](http://codecov.io/github/safx/emoji-swift/coverage.svg?branch=master)](http://codecov.io/github/safx/emoji-swift?branch=master)
![Platform](https://img.shields.io/cocoapods/p/Emoji-swift.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/Emoji-swift.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/Emoji-swift.svg?style=flat)
![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

![](emoji_playground.png)

`String` extension converting to and from emoji character and [Emoji Cheat Sheet](http://www.emoji-cheat-sheet.com/) string.

## Example Usage

```swift
import Emoji

":heart_eyes: :heart: :beer:".emojiUnescapedString
"🐶🐱🐷".emojiEscapedString
```

## Methods

```swift
extension String {
    var emojiEscapedString: String
    var emojiUnescapedString: String
    static var emojiDictionary : [String:String]
}
```

## Custom Emoji

You can add own custom emoji to `String.emojiDictionary`.

If you use custom emojis, you should use only alpha-numeric characters for keys of `emojiDictionary` to avoid any converting problem since this library internally uses RegExp to convert emojis.

```swift
// Setup Custom Emoji
var emojiDictionary = String.emojiDictionary
emojiDictionary["custom_baby"] = "\u{1F476}\u{1F3FB}"
emojiDictionary["custom_baby2"] = "\u{1F476}\u{1F3FF}"
String.emojiDictionary = emojiDictionary


// Using Custom Emoji
":baby::custom_baby::custom_baby2:".emojiUnescapedString
"👶👶🏻👶🏿".emojiEscapedString
```

## Install

### CocoaPods

```
pod 'Emoji-swift'
```

### Swift Package Manager

Create a Package.swift file:

```
import PackageDescription

let package = Package(
    name: "Emoji",
    dependencies: [
        .Package(url: "https://github.com/safx/Emoji-Swift.git", majorVersion: 0)
    ]
)
```

And then, type `swift build`.

### Manual Install

Just copy `Emoji.swift` and `String+Emoji.swift` into your project.
