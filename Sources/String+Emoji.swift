//
//  String+Emoji.swift
//  emoji-swift
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation


extension String {

    fileprivate static var emojiUnescapeRegExp = createEmojiUnescapeRegExp()
    fileprivate static var emojiEscapeRegExp   = createEmojiEscapeRegExp()
    fileprivate static var indexedShortnames   = indexShortnames()
    fileprivate static var indexedCodepoints   = indexCodepoints()

    fileprivate static func createEmojiUnescapeRegExp() -> NSRegularExpression? {
        let v = Emoji.allCases.flatMap { $0.shortnames }
            .map { ":\(NSRegularExpression.escapedPattern(for: $0)):" }
        do {
            let regex = try NSRegularExpression(pattern: v.joined(separator: "|"), options: [])
            return regex
        } catch {
            print(error)
        }
        return nil
    }

    fileprivate static func createEmojiEscapeRegExp() -> NSRegularExpression? {
        let v = Emoji.allCases.flatMap { $0.codepoints }
            .map { NSRegularExpression.escapedPattern(for: $0) }
            .sorted()
            .reversed()
        do {
            let regex = try NSRegularExpression(pattern: v.joined(separator: "|"), options: [])
            return regex
        } catch {
            print(error)
        }
        return nil
    }
    
    fileprivate static func indexShortnames() -> [String: Int] {
        let emojis = Emoji.allCases
        return emojis.reduce([String: Int](), { dict, emoji -> [String: Int] in
            guard let index = emojis.firstIndex(of: emoji) else { return [:] }
            return emoji.shortnames.reduce(dict, { eDict, shortname -> [String: Int] in
                var finalDict = eDict
                finalDict[shortname] = index
                return finalDict
            })
        })
    }
    
    fileprivate static func indexCodepoints() -> [String: Int] {
        let emojis = Emoji.allCases
        return emojis.reduce([String: Int](), { dict, emoji -> [String: Int] in
            guard let index = emojis.firstIndex(of: emoji) else { return [:] }
            return emoji.codepoints.reduce(dict, { eDict, codepoint -> [String: Int] in
                var finalDict = eDict
                finalDict[codepoint] = index
                return finalDict
            })
        })
    }
    
    public var emojiUnescapedString: String {
        var s = self as NSString
        let ms = String.emojiUnescapeRegExp?.matches(in: self, options: [], range: NSMakeRange(0, s.length))
        ms?.reversed().forEach { m in
            let r = m.range
            let p = s.substring(with: r)
            let px = p[p.index(after: p.startIndex) ..< p.index(before: p.endIndex)]
            let index = String.indexedShortnames[String(px)]
            if let i = index {
                let e = Emoji.allCases[i]
                s = s.replacingCharacters(in: r, with: e.codepoints.first!) as NSString
            }
        }
        return s as String
    }

    public var emojiEscapedString: String {
        var s = self as NSString
        let ms = String.emojiEscapeRegExp?.matches(in: self, options: [], range: NSMakeRange(0, s.length))
        ms?.reversed().forEach { m in
            let r = m.range
            let p = s.substring(with: r)
            let index = String.indexedCodepoints[p]
            if let i = index {
                let e = Emoji.allCases[i]
                s = s.replacingCharacters(in: r, with: ":\(e.shortnames.first!):") as NSString
            }
        }
        return s as String
    }

}
