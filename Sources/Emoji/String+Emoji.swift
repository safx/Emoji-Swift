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
    fileprivate static var indexedShortnames   = createIndex(for: \.shortnames)
    fileprivate static var indexedCodepoints   = createIndex(for: \.codepoints)
   
    fileprivate static func createEmojiUnescapeRegExp() -> NSRegularExpression? {
        let pattern = Emoji.allCases
            .flatMap { $0.shortnames }
            .map { ":\(NSRegularExpression.escapedPattern(for: $0)):" }
            .joined(separator: "|")
        do {
            return try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            print(error)
        }
        return nil
    }

    fileprivate static func createEmojiEscapeRegExp() -> NSRegularExpression? {
        let pattern = Emoji.allCases
            .flatMap { $0.codepoints }
            .map { NSRegularExpression.escapedPattern(for: $0) }
            .sorted()
            .reversed()
            .joined(separator: "|")
        do {
            return try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            print(error)
        }
        return nil
    }

    fileprivate static func createIndex(for propertyFunction: (Emoji) -> [String]) -> [String: Int] {
        Emoji.allCases.reduce([String: Int](), { dict, emoji -> [String: Int] in
            guard let index = Emoji.allCases.firstIndex(of: emoji) else { return [:] }
            return propertyFunction(emoji).reduce(dict, { eDict, shortname -> [String: Int] in
                var finalDict = eDict
                finalDict[shortname] = index
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
            if let i = String.indexedShortnames[String(px)] {
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
            if let i = String.indexedCodepoints[p] {
                let e = Emoji.allCases[i]
                s = s.replacingCharacters(in: r, with: ":\(e.shortnames.first!):") as NSString
            }
        }
        return s as String
    }

}
