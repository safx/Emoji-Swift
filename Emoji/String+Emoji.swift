//
//  String+Emoji.swift
//  emoji-swift
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation

extension String {

    fileprivate static var emojiUnescapeRegExp : NSRegularExpression {
        struct Static {
            static let instance = try! NSRegularExpression(pattern: emoji.keys.map { ":\($0):" } .joined(separator: "|"), options: [])
        }
        return Static.instance
    }

    fileprivate static var emojiEscapeRegExp : NSRegularExpression {
        struct Static {
            static let instance = try! NSRegularExpression(pattern: emoji.values.lazy.joined(separator: "|"), options: [])
        }
        return Static.instance
    }

    public static var emojiDictionary : [String:String] {
        return emoji
    }

    public var emojiUnescapedString: String {
        var s = self as NSString
        let ms = String.emojiUnescapeRegExp.matches(in: self, options: [], range: NSMakeRange(0, s.length))
        ms.reversed().forEach { m in
            let r = m.range
            let p = s.substring(with: r)
            let px = p.substring(with: p.characters.index(after: p.startIndex) ..< p.characters.index(before: p.endIndex))
            if let t = emoji[px] {
                s = s.replacingCharacters(in: r, with: t) as NSString
            }
        }
        return s as String
    }

    public var emojiEscapedString: String {
        var s = self as NSString
        let ms = String.emojiEscapeRegExp.matches(in: self, options: [], range: NSMakeRange(0, s.length))
        ms.reversed().forEach { m in
            let r = m.range
            let p = s.substring(with: r)
            let fs = emoji.lazy.filter { $0.1 == p }
            if let kv = fs.first {
                s = s.replacingCharacters(in: r, with: ":\(kv.0):") as NSString
            }
        }
        return s as String
    }

}
