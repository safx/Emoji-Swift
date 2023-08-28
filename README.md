# Emoji-Swift

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
}
```

## Install

### CocoaPods

```ruby
pod 'Emoji-swift'
```

## How to update emoji

```bash
cd tools
curl -LO  https://raw.githubusercontent.com/joypixels/emoji-toolkit/master/emoji.json
python ./gen-emoji-swift.py > ../Sources/Emoji/Emoji.swift
```
