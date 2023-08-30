//
//  String+Emoji.swift
//  emoji-swift
//
//  Created by Safx Developer on 2015/04/07.
//  Copyright (c) 2015 Safx Developers. All rights reserved.
//

import Foundation

extension String {
    public var emojiUnescapedString: String {
        var s = self as NSString
        Emoji.unescapeRegExp?
            .matches(in: self, options: [], range: NSMakeRange(0, s.length))
            .reversed()
            .forEach { m in
                let r = m.range
                let p = s.substring(with: r)
                let px = p[p.index(after: p.startIndex) ..< p.index(before: p.endIndex)]
                if let i = Emoji.indexedShortnames[String(px)],
                   let codepoint = Emoji.allCases[i].codepoints.first {
                    s = s.replacingCharacters(in: r, with: codepoint) as NSString
                }
            }
        return s as String
    }

    public var emojiEscapedString: String {
        var s = self as NSString
        Emoji.escapeRegExp?
            .matches(in: self, options: [], range: NSMakeRange(0, s.length))
            .reversed()
            .forEach { m in
                let r = m.range
                let p = s.substring(with: r)
                if let i = Emoji.indexedCodepoints[p],
                   let shortname = Emoji.allCases[i].shortnames.first {
                    s = s.replacingCharacters(in: r, with: ":\(shortname):") as NSString
                }
            }
        return s as String
    }
}

fileprivate extension Emoji {
    static let unescapeRegExp    = createEmojiUnescapeRegExp()
    static let escapeRegExp      = createEmojiEscapeRegExp()
    static let indexedShortnames = createIndex(for: \.shortnames)
    static let indexedCodepoints = createIndex(for: \.codepoints)
   
    static func createEmojiUnescapeRegExp() -> NSRegularExpression? {
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

    static func createEmojiEscapeRegExp() -> NSRegularExpression? {
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

    static func createIndex(for propertyFunction: (Emoji) -> [String]) -> [String: Int] {
        Emoji.allCases.reduce([String: Int](), { dict, emoji -> [String: Int] in
            guard let index = Emoji.allCases.firstIndex(of: emoji) else { return [:] }
            return propertyFunction(emoji).reduce(dict, { eDict, shortname -> [String: Int] in
                var finalDict = eDict
                finalDict[shortname] = index
                return finalDict
            })
        })
    }
}
