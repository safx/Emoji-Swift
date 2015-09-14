//
//  String+Emoji.swift
//  emoji-swift
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation

extension String {

    private static var emojiUnescapeRegExp : NSRegularExpression {
        struct Static {
            static let instance = try! NSRegularExpression(pattern: emoji.keys.map { ":\($0):" } .joinWithSeparator("|"), options: [])
        }
        return Static.instance
    }

    private static var emojiEscapeRegExp : NSRegularExpression {
        struct Static {
            static let instance = try! NSRegularExpression(pattern: emoji.values.lazy.joinWithSeparator("|"), options: [])
        }
        return Static.instance
    }

    public static var emojiDictionary : [String:String] {
        return emoji
    }

    public var emojiUnescapedString: String {
        var s = self as NSString
        let ms = String.emojiUnescapeRegExp.matchesInString(self, options: [], range: NSMakeRange(0, s.length))
        ms.reverse().forEach { m in
            let r = m.range
            let p = s.substringWithRange(r)
            let px = p.substringWithRange(Range<String.Index>(start: p.startIndex.successor(), end: p.endIndex.predecessor()))
            if let t = emoji[px] {
                s = s.stringByReplacingCharactersInRange(r, withString: t)
            }
        }
        return s as String
    }

    public var emojiEscapedString: String {
        var s = self as NSString
        let ms = String.emojiEscapeRegExp.matchesInString(self, options: [], range: NSMakeRange(0, s.length))
        ms.reverse().forEach { m in
            let r = m.range
            let p = s.substringWithRange(r)
            let fs = emoji.lazy.filter { $0.1 == p }
            if let kv = fs.first {
                s = s.stringByReplacingCharactersInRange(r, withString: ":\(kv.0):")
            }
        }
        return s as String
    }

}
