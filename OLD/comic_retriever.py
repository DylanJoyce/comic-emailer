#! /usr/bin/env python

# This script grabs selected comic strip images from gocomics.com, then emails them to specified addresses.

import datetime
import re
import urllib
import os
import errno
import comic_settings

today = str(datetime.date.today())
comic_directory = '/Users/Plemer/Comics/' + today
comics = ['calvinandhobbes', 'foxtrotclassics']

class MyOpener(urllib.URLopener):
    version = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11'

base_url = 'http://www.gocomics.com/'
img_re = re.compile(r'src="(http://assets\.amuniversal\.com/[a-z0-9]{32}\?width=900.0)"')

def get_image_url(comic):
    url = base_url + comic + '/'
    myopener = MyOpener()
    page = myopener.open(url)
    response = page.read()
    match = img_re.search(response)
    image_url = match.group(1)
    return image_url    
    
os.mkdir(comic_directory)

for comic in comics:
    print(comic + " complete")
    image = urllib.urlopen(get_image_url(comic)).read()
    filename = comic_directory + "/" + today + ' ' + comic + '.jpg'
    f = open(filename, 'w')
    f.write(image)
    f.close()
    
    
