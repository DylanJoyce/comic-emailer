#!/usr/bin/python

import datetime
import smtplib
import os
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import formatdate
from email import Encoders
import comic_settings
    
gmail_user = comic_settings.gmail_user
gmail_password = comic_settings.gmail_password
gmail_smtp = comic_settings.gmail_smtp
recipients = comic_settings.recipients

today = str(datetime.date.today())
comic_directory = '/Users/Plemer/Comics/' + today
comics = ['calvinandhobbes', 'foxtrotclassics']
comics_pretty = ['Calvin and Hobbes by Bill Watterson', 'Foxtrot Classics by Bill Amend']
files = []

#creates filenames from comic directory and comic title, and adds these names to the "files" list 
for comic in comics:
    filename = comic_directory + "/" + today + ' ' + comic + '.jpg'
    files.append(filename)

def send_mail(send_from, send_to, subject, text, files = []):

    msg = MIMEMultipart()
    msg['From'] = send_from
    msg['To'] = ", ".join(send_to)
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject

    n = 0

    for f in files:
        msg.attach( MIMEText(comics_pretty[n]) )
        part = MIMEBase('application', 'octet-stream')
        part.set_payload(open(f, 'rb').read())
        Encoders.encode_base64(part)
        part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(f))
        msg.attach(part)
        n += 1

    mailServer = smtplib.SMTP(smtp, port)               
    mailServer.ehlo()
    mailServer.starttls()
    mailServer.ehlo()
    mailServer.login(sender, password)
    mailServer.sendmail(gmail_user, recipients, msg.as_string())
    # Should be mailServer.quit(), but that crashes...
    mailServer.close()
    
send_mail(gmail_user, recipients, today + " comics", today, files)