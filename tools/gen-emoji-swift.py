#!/usr/bin/python

import json, re

EXCLUDES = [
    '^regional_indicator_[a-z]$',
#    '^.+_tone[0-9]$', # TODO: skin tone modifier
    'asterisk'        # TODO: need to escape in NSRegularExpression
]

def p(emoji_shortname, hyphenated_codepoints):
    cs = map(lambda cp: '"' + ''.join(map(lambda e: '\u{%s}' % e, cp.split('-'))) + '"', hyphenated_codepoints)
    print('  Emoji(shortname: %-33s, codepoints: [%s]),' % ('"' + emoji_shortname + '"', (',\n' + ' ' * 67).join(cs)))

def prn(key, value, target_category):
    shortname = value['shortname'][1:-1] # remove `:`
    category = value['category']
    default_matches = value['code_points']['default_matches']

    if any(map(lambda e: re.match(e, shortname), EXCLUDES)):
        return

    p(shortname, default_matches)

def cmp(a, b):
    if a == b: return 0

    sa = (a.split('-') + ['0', '0', '0'])[:4]
    sb = (b.split('-') + ['0', '0', '0'])[:4]

    v = lambda a, e: a * 0x100000 + int(e, 16)
    aa = reduce(v, sa, 0)
    bb = reduce(v, sb, 0)
    return 1 if aa > bb else -1


# curl -LO https://raw.githubusercontent.com/emojione/emojione/master/emoji.json

head = '''//
//  This file is based on EmojiOne:
//   https://raw.githubusercontent.com/emojione/emojione/master/emoji.json
//
//  Emoji.swift
//
//  Created by Safx Developer on 2017/02/26.
//  Copyright (c) 2017 Safx Developers. All rights reserved.
//


public struct Emoji {
    let shortname: String
    let codepoints: [String]

    public init(shortname: String, codepoints: [String]) {
        self.shortname = shortname
        self.codepoints = codepoints
    }
}

internal let emoji: [Emoji] = [
'''

json = json.load(file('emoji.json'))
keys = sorted(json.keys(), cmp)
print(head)
for k in keys:
    prn(k, json[k], None)
print(']')
