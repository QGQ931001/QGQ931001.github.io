import sys
sys.stdout.reconfigure(encoding='utf-8')
import fitz

pdf_path = r'E:\Zotero\storage\X936XRIH\Baumann和Klymak - 2024 - Do governments crowd out governments Evidence from a natural experiment.pdf'
output_path = r'C:\Users\Lenovo\Nutstore\1\source\crowd_out_gov_paper.txt'

doc = fitz.open(pdf_path)
total = len(doc)
print(f'Total pages: {total}')

text = []
for i, page in enumerate(doc):
    text.append(page.get_text())
    if (i+1) % 50 == 0:
        print(f'Processed {i+1}/{total} pages')

with open(output_path, 'w', encoding='utf-8') as f:
    f.write('\n\n'.join(text))

print(f'Saved {len(text)} pages to {output_path}')
doc.close()
