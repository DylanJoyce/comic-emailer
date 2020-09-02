#!/usr/bin/python

import datetime
import comic_url_retriever

img_urls = comic_url_retriever.img_urls
comics_pretty = ['Calvin and Hobbes by Bill Watterson', 'Foxtrot Classics by Bill Amend', 'Non Sequitur by Wiley']

today = str(datetime.date.today())

subject = today + " comics"
plain_text = "HTML email must be enabled to view these comics."
table_contents = []

comic_quantity = 3
n = 0

# creates html table content for the specified number of comics
while n < comic_quantity:
    table_content = '''
    <tr>
        <th align="left"> <FONT SIZE=5>''' + comics_pretty[n] + ''' </FONT> </th>
    </tr>
        <td><img style="border:0;" src="''' + img_urls[n] + '''" alt="''' + comics_pretty[n] + '''" /></td> 
'''
    table_contents.append(table_content)
    n += 1
    
html_text = '''

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>''' + subject + '''</title>
</head>

<body>
 
<table border="0" align="center">
''' + table_contents[0] + table_contents[1] + table_contents[2] + '''
</table>

</body>
</html>
'''
