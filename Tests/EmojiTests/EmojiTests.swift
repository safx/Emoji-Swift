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
    }
    
    func testCustomEmoji() {
        var emojis = String.emojis
        emojis.append(Emoji(shortname: "heart_alt", codepoints: ["\u{2764}"]))
        emojis.append(Emoji(shortname: "amp", codepoints: ["&\u{20dd}"]))
        
        String.emojis = emojis

        XCTAssertEqual("❤", ":heart_alt:".emojiUnescapedString)
        XCTAssertEqual("&⃝", ":amp:".emojiUnescapedString)

        XCTAssertEqual(":heart_alt:", "❤".emojiEscapedString)
        XCTAssertEqual(":amp:", "&⃝".emojiEscapedString)
    }

    func testIssue9fixture() {
        XCTAssertEqual(":heart:", "❤️".emojiEscapedString)
        XCTAssertEqual(":hash:", "#️⃣".emojiEscapedString)
        XCTAssertEqual(":hash:", "#⃣".emojiEscapedString)
    }
    
    func testEmojiUnescapePerformance() {
        measure {
            for _ in 1...50 {
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
            for _ in 1...50 {
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
