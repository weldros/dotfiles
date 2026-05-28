import json
import re
from pathlib import Path

pywal_json = Path("/home/piyush/.cache/wal/colors.json")
target_file = Path("/home/piyush/.config/conky/conky.conf")

# Load pywal colors
with open(pywal_json) as f:
    wal_colors = json.load(f)["colors"]

# Match lines like:
#     color1 = '#9F6D95',
pattern = re.compile(r'(color\d+)\s*=\s*[\'"]#?[0-9a-fA-F]{6}[\'"]')

with open(target_file) as f:
    lines = f.readlines()

new_lines = []

for line in lines:
    match = pattern.search(line)
    if match:
        key = match.group(1)
        if key in wal_colors:
            hex_val = wal_colors[key]
            line = re.sub(
                pattern,
                f"{key} = '{hex_val}'",
                line
            )
    new_lines.append(line)

with open(target_file, "w") as f:
    f.writelines(new_lines)
