#!/usr/bin/python

import json, re

USE_ALIASES = False

EXCLUDES = [
    '.+_tone[0-9]:',
    ':regional_indicator_[a-z]:',
    ':asterisk:'   # TODO: need to escape in NSRegularExpression
]

def p(key, value):
    assert(key[0] == ':' and key[-1] == ':')
    key_body = key[1:-1]
    print('    %-33s : "%s",' % ('"' + key_body + '"', value))

def prn(key, value):
    alpha_code = value['alpha_code']
    aliases = value['aliases']

    if any(map(lambda e: re.match(e, alpha_code), EXCLUDES)):
        return

    unicode_chars = ''.join(map(lambda e: '\u{%s}' % e, key.split('-')))

    p(alpha_code, unicode_chars)
    if USE_ALIASES and len(aliases) > 0:
        for a in aliases.split('|'):
            p(a, unicode_chars)

def cmp(a, b):
    if a == b: return 0

    sa = (a.split('-') + ['0', '0', '0'])[:4]
    sb = (b.split('-') + ['0', '0', '0'])[:4]

    v = lambda a, e: a * 0x100000 + int(e, 16)
    aa = reduce(v, sa, 0)
    bb = reduce(v, sb, 0)
    return 1 if aa > bb else -1


# curl -LO https://raw.githubusercontent.com/Ranks/emoji-alpha-codes/master/eac.json

head = '''//
//  This file is based on Ranks/emoji-alpha-codes
//   (https://github.com/Ranks/emoji-alpha-codes/blob/master/eac.json).
//
//  Emoji.swift
//
//  Created by Safx Developer on 2017/02/26.
//  Copyright (c) 2017 Safx Developers. All rights reserved.
//

internal let emoji: [String:String] = ['''
tail = ']'

json = json.load(file('eac.json'))
keys = sorted(json.keys(), cmp)

print(head)
for k in keys:
    prn(k, json[k])
print(tail)
