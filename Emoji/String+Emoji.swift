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
            static let instance = NSRegularExpression(pattern: "|".join(emoji.keys.map{ ":\($0):" }), options: NSRegularExpressionOptions(0), error: nil)!
        }
        return Static.instance
    }

    private static var emojiEscapeRegExp : NSRegularExpression {
        struct Static {
            static let instance = NSRegularExpression(pattern: "|".join(emoji.values), options: NSRegularExpressionOptions(0), error: nil)!
        }
        return Static.instance
    }

    public static var emojiDictionary : [String:String] {
        return emoji
    }

    public var emojiUnescapedString: String {
        var s = self as NSString
        let ms = String.emojiUnescapeRegExp.matchesInString(s, options: NSMatchingOptions(0), range: NSMakeRange(0, s.length))

        for m in reverse(ms) {
            let r = m.range
            let p = s.substringWithRange(r)
            let px = p.substringWithRange(Range<String.Index>(start: p.startIndex.successor(), end: p.endIndex.predecessor()))
            if let t = emoji[px] {
                s = s.stringByReplacingCharactersInRange(r, withString: t)
            }
        }
        return s
    }

    public var emojiEscapedString: String {
        var s = self as NSString
        let ms = String.emojiEscapeRegExp.matchesInString(s, options: NSMatchingOptions(0), range: NSMakeRange(0, s.length))

        for m in reverse(ms) {
            let r = m.range
            let p = s.substringWithRange(r)
            let fs = filter(emoji, { (k,v) in v == p })
            if countElements(fs) > 0 {
                let kv = fs[0]
                s = s.stringByReplacingCharactersInRange(r, withString: ":\(kv.0):")
            }
        }
        return s
    }

}
