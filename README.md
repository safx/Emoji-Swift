# emoji-swift

[![TravisCI](http://img.shields.io/travis/safx/emoji-swift.svg?style=flat)](https://travis-ci.org/safx/emoji-swift)
[![codecov.io](http://codecov.io/github/safx/emoji-swift/coverage.svg?branch=master)](http://codecov.io/github/safx/emoji-swift?branch=master)
![Platform](https://img.shields.io/cocoapods/p/Emoji-swift.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/Emoji-swift.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/Emoji-swift.svg?style=flat)

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

## Install

```
pod 'Emoji-swift'
```
