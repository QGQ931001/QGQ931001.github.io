#!/usr/bin/env python3
"""Clean up the blog notes - remove mixed content and normalize format."""

# File 1: ashraf-2013-out-of-africa.md
# Need to remove: lines 271 onwards (sentence-by-sentence analysis starting with "好的,我们来逐句解释")
ashraf_path = r"c:\Users\Lenovo\Nutstore\1\source\_posts\ashraf-2013-out-of-africa.md"
with open(ashraf_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find where the unwanted content starts (line 271 in 1-indexed = line 270 in 0-indexed)
# The unwanted part starts with "好的,我们来逐句解释"
cut_idx = None
for i, line in enumerate(lines):
    if "好的,我们来逐句解释和分析这段内容" in line or "好的，我们来逐句解释和分析这段内容" in line:
        cut_idx = i
        break

if cut_idx:
    # Keep lines up to cut_idx (exclusive), plus remove trailing empty lines
    cleaned_lines = lines[:cut_idx]
    # Remove trailing empty lines
    while cleaned_lines and cleaned_lines[-1].strip() == '':
        cleaned_lines.pop()
    with open(ashraf_path, 'w', encoding='utf-8') as f:
        f.writelines(cleaned_lines)
    print(f"ashraf: Cleaned, removed lines {cut_idx+1}-{len(lines)}")
else:
    print("ashraf: Could not find cut point")

# File 2: liebman-2017-expiring-budgets.md
# Need to remove: mixed content from ashraf file starting around line 180+
liebman_path = r"c:\Users\Lenovo\Nutstore\1\source\_posts\liebman-2017-expiring-budgets.md"
with open(liebman_path, 'r', encoding='utf-8') as f:
    content = f.read()

# The liebman file got polluted with ashraf content around the Radon-Nikodym theorem proof
# Find where "Do Expiring Budgets" should end and ashraf content begins
# The pollution starts with the math proof and sentence analysis

# Find the marker where ashraf content was inserted
pollution_markers = [
    "好的,我来证明 ∫A E(Y|X) dP = ∫A Y dP",
    "好的，现在我来帮你梳理和简化这篇 American Economic Review",
    "## 引言(背景和意义):阐述文章的研究领域和关注点",
]

cut_idx = None
lines = content.split('\n')
for i, line in enumerate(lines):
    for marker in pollution_markers:
        if marker in line:
            cut_idx = i
            break
    if cut_idx:
        break

if cut_idx:
    cleaned_lines = lines[:cut_idx]
    while cleaned_lines and cleaned_lines[-1].strip() == '':
        cleaned_lines.pop()
    with open(liebman_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(cleaned_lines))
    print(f"liebman: Cleaned, removed lines {cut_idx+1}-{len(lines)}")
else:
    print("liebman: Could not find cut point")
    print(f"  Total lines: {len(lines)}")

print("Done!")
