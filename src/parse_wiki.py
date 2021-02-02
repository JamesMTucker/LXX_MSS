# -*- encoding: utf-8 -*-

### James M. Tucker, Ph.D.
### Download wiki data and parse into csv

import os
import requests
import re
import csv
from bs4 import BeautifulSoup

wiki_source = requests.get("https://en.wikipedia.org/wiki/Septuagint_manuscripts")
soup = BeautifulSoup(wiki_source.text, 'lxml')

tables = soup.findAll("table", {"class":"wikitable sortable"})

output_rows = []
for table_row in tables[0].findAll('tr'):
    columns = table_row.findAll('td')
    output_row = []
    for column in columns:
        output_row.append(column.text.strip())
    output_rows.append(output_row)

with open('uncials.csv', 'w') as f:
    writer = csv.writer(f)
    writer.writerows(output_rows)