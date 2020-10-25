#!/usr/bin/python

import json, re
from functools import cmp_to_key
from functools import reduce

EXCLUDES = [
    '^regional_indicator_[a-z]$',
#    '^.+_tone[0-9]$', # TODO: skin tone modifier
    'asterisk'        # TODO: need to escape in NSRegularExpression
]

def pcase(name):
    print('    case %s' % (name))

def pshortname(name, emoji_shortnames):
    shortnames = ['"' + s + '"' for s in emoji_shortnames]
    print('        case .%s:' % (name))
    print('            return [%s]' % (((',\n' + ' ' * 20).join(shortnames))))

def pcodepoints(name, hyphenated_codepoints):
    cs = map(lambda cp: '"' + ''.join(map(lambda e: r'\u{%s}' % e, cp.split('-'))) + '"', hyphenated_codepoints)
    print('        case .%s:' % (name))
    print('            return [%s]' % (((',\n' + ' ' * 20).join(cs))))

def cmp(a, b):
    if a == b: return 0

    sa = (a.split('-') + ['0', '0', '0'])[:4]
    sb = (b.split('-') + ['0', '0', '0'])[:4]

    v = lambda a, e: a * 0x100000 + int(e, 16)
    aa = reduce(v, sa, 0)
    bb = reduce(v, sb, 0)
    return 1 if aa > bb else -1


# curl -LO https://raw.githubusercontent.com/joypixels/emoji-toolkit/master/emoji.json

head = '''//
//  This file is based on EmojiOne:
//   https://raw.githubusercontent.com/joypixels/emoji-toolkit/master/emoji.json
//
//  Emoji.swift
//
//  Created by Safx Developer on 2017/02/26.
//  Copyright (c) 2017 Safx Developers. All rights reserved.
//

public enum Emoji: CaseIterable {
'''

json = json.load(open('emoji.json'))
keys = sorted(json.keys(), key = cmp_to_key(cmp))
print(head)

emojis = []

for k in keys:
    value = json[k]

    shortnames = []
    shortnames.append(value['shortname'][1:-1]) # remove `:`
    shortnames.extend([s[1:-1] for s in value['shortname_alternates']])
    for regex in EXCLUDES:
        shortnames = [shortname for shortname in shortnames if re.match(regex, shortname) is None]

    if len(shortnames) == 0:
        continue

    name = shortnames[0].replace('-', '_')
    name_substitutions = [('8ball', 'eight_ball'),
                          ('guard', '`guard`'),
                          ('100', 'hundred'),
                          ('repeat', '`repeat`'),
                          ('1234', 'one_two_three_four')]

    for sub in name_substitutions:
        if name == sub[0]:
            name = sub[1]

    cp_base = value['code_points']['base']
    cp_fq   = value['code_points']['fully_qualified']
    matches = [cp_base] if cp_base == cp_fq else [cp_base, cp_fq]

    emojis.append((name, shortnames, matches))

for emoji in emojis:
    pcase(emoji[0])

shortnames_var = '''
    var shortnames: [String] {
        switch(self) {'''

print(shortnames_var)
for emoji in emojis:
    pshortname(emoji[0], emoji[1])
default_case_var = '''        default:
            fatalError()'''

print(default_case_var)

print('        }')
print('    }')

codepoints_var = '''
    var codepoints: [String] {
        switch(self) {'''

print(codepoints_var)
for emoji in emojis:
    pcodepoints(emoji[0], emoji[2])

print(default_case_var)
print('        }')
print('    }')
print('''
}''')
