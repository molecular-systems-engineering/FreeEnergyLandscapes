#!/usr/bin/env python3
import re
import sys

text = sys.stdin.read()

anchor_re = re.compile(
    r'<a\s+[^>]*href="#([^"]+)"[^>]*>(.*?)</a>',
    re.DOTALL | re.IGNORECASE,
)

def replace_anchor(m):
    target = m.group(1)
    label = m.group(2).strip()
    # collapse whitespace
    label = re.sub(r'\s+', ' ', label)
    # drop leading/trailing [ ] if present
    label = re.sub(r'^\s*\[', '', label)
    label = re.sub(r'\]\s*$', '', label)
    return f'[{label}](#{target})'

out = anchor_re.sub(replace_anchor, text)
sys.stdout.write(out)

