#!/usr/bin/python

import re
import urllib
import os
import errno

comic_quantity = 3
comics = ['calvinandhobbes', 'foxtrotclassics', 'nonsequitur']

img_urls = []

class MyOpener(urllib.URLopener):
    version = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11'

base_url = 'http://www.gocomics.com/'
img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')

#defines function that will retrieve image urls
def get_image_url(comic):
    url = base_url + comic + '/'
    myopener = MyOpener()
    page = myopener.open(url)
    response = page.read()
    match = img_re.search(response)
    image_url = match.group(1)
    return image_url

#call image_url function on all items in comics and appends to img_urls list
for c in comics:
    img_url = get_image_url(c)
    img_urls.append(img_url)
