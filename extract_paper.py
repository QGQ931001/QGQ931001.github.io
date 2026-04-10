import json, sys, re
sys.stdout.reconfigure(encoding='utf-8')

input_file = r'C:\Users\Lenovo\.claude\projects\c--Users-Lenovo-Nutstore-1-source\243ad2db-7b30-43f1-a863-58cb45d29df7\tool-results\mcp-zotero-mcp-get_content-1775826657020.txt'
output_file = r'C:\Users\Lenovo\Nutstore\1\source\who_becomes_politician_paper.txt'

with open(input_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

content = data[0]['text']

# Parse the nested JSON content
if isinstance(content, str):
    content = json.loads(content)

# Extract the PDF text
pdf_content = content.get('content', {}).get('attachments', [{}])[0].get('content', '')

# Clean up the content - remove excessive whitespace but keep structure
lines = pdf_content.split('\n')
cleaned_lines = []
for line in lines:
    line = line.strip()
    if line:
        cleaned_lines.append(line)

final_content = '\n\n'.join(cleaned_lines)

with open(output_file, 'w', encoding='utf-8') as out:
    out.write(final_content)

print(f"Extracted {len(final_content)} characters to {output_file}")
