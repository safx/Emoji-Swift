//: Playground - noun: a place where people can play

import Emoji

// Example Usage
":heart_eyes: :heart: :beer:".emojiUnescapedString
"🐶🐱🐷".emojiEscapedString


// Setup Custom Emoji
var emojiDictionary = String.emojiDictionary
emojiDictionary["custom_baby"] = "\u{1F476}\u{1F3FB}"
emojiDictionary["custom_baby2"] = "\u{1F476}\u{1F3FF}"
String.emojiDictionary = emojiDictionary


// Using Custom Emoji
":baby::custom_baby::custom_baby2:".emojiUnescapedString
"👶👶🏻👶🏿".emojiEscapedString

