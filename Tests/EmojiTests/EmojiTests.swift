//
//  EmojiTests.swift
//  EmojiTests
//
//  Created by Safx Developer on 2015/04/08.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation
import XCTest
import Emoji

class EmojiTests: XCTestCase {

    override func setUp() {
        var emojiDictionary = String.emojiDictionary
        emojiDictionary["custom_baby"] = "\u{1F476}\u{1F3FB}"
        emojiDictionary["custom_baby2"] = "\u{1F476}\u{1F3FF}"
        String.emojiDictionary = emojiDictionary
    }
    
    func testEmojiUnescape() {
        XCTAssertEqual("", "".emojiUnescapedString)
        XCTAssertEqual("apple", "apple".emojiUnescapedString)
        XCTAssertEqual(":xxx:", ":xxx:".emojiUnescapedString)
        XCTAssertEqual("\u{1f34e}", ":apple:".emojiUnescapedString)

        XCTAssertEqual(":apxple\u{1f34e}", ":apxple:apple:".emojiUnescapedString)
        XCTAssertEqual("\u{1f34e}apple:", ":apple:apple:".emojiUnescapedString)
        XCTAssertEqual("\u{1f34e}\u{1f37a}", ":apple::beer:".emojiUnescapedString)

        XCTAssertEqual(":apxple\u{1f37a}", ":apxple\u{1f37a}".emojiUnescapedString)
        XCTAssertEqual("\u{1f34e}\u{1f37a}", ":apple:\u{1f37a}".emojiUnescapedString)
        XCTAssertEqual("\u{1f37a}\u{1f34e}", "\u{1f37a}:apple:".emojiUnescapedString)
        XCTAssertEqual("\u{1f34e}house\u{1f37a}", ":apple:house:beer:".emojiUnescapedString)

        XCTAssertEqual("\u{1F476}\u{1F3FB}", ":custom_baby:".emojiUnescapedString)
        XCTAssertEqual("\u{1F476}\u{1F476}\u{1F3FB}\u{1F476}\u{1F3FF}", ":baby::custom_baby::custom_baby2:".emojiUnescapedString)
    }

    func testEmojiEscape() {
        XCTAssertEqual("", "".emojiEscapedString)
        XCTAssertEqual("apple", "apple".emojiEscapedString)
        XCTAssertEqual(":xxx:", ":xxx:".emojiEscapedString)
        XCTAssertEqual(":apple:", "\u{1f34e}".emojiEscapedString)

        XCTAssertEqual(":apxple:apple:", ":apxple\u{1f34e}".emojiEscapedString)
        XCTAssertEqual(":apple:apple:", "\u{1f34e}apple:".emojiEscapedString)
        XCTAssertEqual(":apple::beer:", "\u{1f34e}\u{1f37a}".emojiEscapedString)

        XCTAssertEqual(":apxple:apple:", ":apxple:apple:".emojiEscapedString)
        XCTAssertEqual(":apxple:apple:", ":apxple\u{1f34e}".emojiEscapedString)
        XCTAssertEqual(":apple::beer:", ":apple:\u{1f37a}".emojiEscapedString)
        XCTAssertEqual(":beer::apple:", "\u{1f37a}:apple:".emojiEscapedString)
        XCTAssertEqual(":apple:house:beer:", ":apple:house:beer:".emojiEscapedString)

        XCTAssertEqual(":custom_baby:", "\u{1F476}\u{1F3FB}".emojiEscapedString)
        XCTAssertEqual(":baby::custom_baby::custom_baby2:", "\u{1F476}\u{1F476}\u{1F3FB}\u{1F476}\u{1F3FF}".emojiEscapedString)
    }

    func testEmojiUnescapePerformance() {
        measure {
            for _ in 1...500 {
                XCTAssertEqual("", "".emojiUnescapedString)
                XCTAssertEqual("apple", "apple".emojiUnescapedString)
                XCTAssertEqual(":xxx:", ":xxx:".emojiUnescapedString)
                XCTAssertEqual("\u{1f34e}", ":apple:".emojiUnescapedString)
                
                XCTAssertEqual(":apxple\u{1f34e}", ":apxple:apple:".emojiUnescapedString)
                XCTAssertEqual("\u{1f34e}apple:", ":apple:apple:".emojiUnescapedString)
                XCTAssertEqual("\u{1f34e}\u{1f37a}", ":apple::beer:".emojiUnescapedString)
                
                XCTAssertEqual(":apxple\u{1f37a}", ":apxple\u{1f37a}".emojiUnescapedString)
                XCTAssertEqual("\u{1f34e}\u{1f37a}", ":apple:\u{1f37a}".emojiUnescapedString)
                XCTAssertEqual("\u{1f37a}\u{1f34e}", "\u{1f37a}:apple:".emojiUnescapedString)
                XCTAssertEqual("\u{1f34e}house\u{1f37a}", ":apple:house:beer:".emojiUnescapedString)
            }
        }
    }
    
    func testEmojiEscapePerformance() {
        measure {
            for _ in 1...500 {
                XCTAssertEqual("", "".emojiEscapedString)
                XCTAssertEqual("apple", "apple".emojiEscapedString)
                XCTAssertEqual(":xxx:", ":xxx:".emojiEscapedString)
                XCTAssertEqual(":apple:", "\u{1f34e}".emojiEscapedString)
                
                XCTAssertEqual(":apxple:apple:", ":apxple\u{1f34e}".emojiEscapedString)
                XCTAssertEqual(":apple:apple:", "\u{1f34e}apple:".emojiEscapedString)
                XCTAssertEqual(":apple::beer:", "\u{1f34e}\u{1f37a}".emojiEscapedString)
                
                XCTAssertEqual(":apxple:apple:", ":apxple:apple:".emojiEscapedString)
                XCTAssertEqual(":apxple:apple:", ":apxple\u{1f34e}".emojiEscapedString)
                XCTAssertEqual(":apple::beer:", ":apple:\u{1f37a}".emojiEscapedString)
                XCTAssertEqual(":beer::apple:", "\u{1f37a}:apple:".emojiEscapedString)
                XCTAssertEqual(":apple:house:beer:", ":apple:house:beer:".emojiEscapedString)
            }
        }
    }
}
