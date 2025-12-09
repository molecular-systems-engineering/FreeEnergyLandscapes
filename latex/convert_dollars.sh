#!/usr/bin/env python3
import sys
import re

text = sys.stdin.read()

# 1) Block math: $$ ... $$
text = re.sub(
    r'\$\$(.+?)\$\$',
    r'\\\\[\1\\\\]',
    text,
    flags=re.DOTALL
)

# 2) Inline math: $ ... $ (but not $$)
text = re.sub(
    r'(?<!\$)\$(.+?)\$(?!\$)',
    r'\\\\(\1\\\\)',
    text,
    flags=re.DOTALL
)

sys.stdout.write(text)

