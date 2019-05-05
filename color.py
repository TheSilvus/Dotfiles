#!/usr/bin/env python3

import sys
import os

color_schemes = ["dark", "light"]

scheme = sys.argv[1]
if scheme not in color_schemes:
    print("Unknown color scheme")
    sys.exit(0)


files = [
    "~/.config/i3/config",
    # "~/.config/i3/polybar",
    # "~/.config/i3/termite/config",
    # "~/.config/i3/rofi/config",
]

for filename in files:
    filename = os.path.expanduser(filename)
    basename = filename + "_base"
    schemename = filename + "_colorscheme-" + scheme

    print(f"Combining {filename} from {basename} and {schemename}")

    with open(basename, "r") as f:
        base = f.read()
    with open(schemename, "r") as f:
        scheme = f.read()

    complete = scheme + "\n" + base

    with open(filename, "w+") as f:
        f.write(complete)
