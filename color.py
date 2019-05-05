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
    "~/.config/i3/polybar",
    "~/.config/termite/config",
    # "~/.config/i3/rofi/config",
]

for filename in files:
    filename = os.path.expanduser(filename)
    basename = filename + "_base"
    schemename = filename + "_colorscheme-" + scheme

    print(f"Combining {filename} from {basename} and {schemename}")

    with open(basename, "r") as f:
        base_content = f.read()
    with open(schemename, "r") as f:
        scheme_content = f.read()

    complete_content = scheme_content + "\n" + base_content

    with open(filename, "w+") as f:
        f.write(complete_content)

with open(os.path.expanduser("~/.colorscheme"), "w+") as f:
    f.write(scheme)

