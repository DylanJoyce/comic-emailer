#!/usr/bin/python

import smtplib

from email.Utils import formatdate
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email import Encoders

import comicdeliverer_at_gmail_settings
import comics_email_text

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

sender = comicdeliverer_at_gmail_settings.sender
recipients = comicdeliverer_at_gmail_settings.recipients
password = comicdeliverer_at_gmail_settings.password
smtp = comicdeliverer_at_gmail_settings.smtp 
port = comicdeliverer_at_gmail_settings.port 

plain_text = comics_email_text.plain_text
html_text = comics_email_text.html_text
subject = comics_email_text.subject 

# Create message container - the correct MIME type is multipart/alternative.
msg = MIMEMultipart('alternative')
msg['From'] = sender
msg['To'] = ', '.join(recipients)
msg['Date'] = formatdate(localtime=True)
msg['Subject'] = subject

# Creates the body of the message (a plain-text and an HTML version).
def send_mail(send_from, send_to, subject, text):
    text = plain_text
    html = html_text
    
    # Record the MIME types of both parts - text/plain and text/html.
    part1 = MIMEText(text, 'plain')
    part2 = MIMEText(html, 'html')
    
    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case the HTML message, is best and preferred.
    msg.attach(part1)
    msg.attach(part2)
    
    # Send the message via SMTP server specified in settings.
    
    mailServer = smtplib.SMTP(smtp, port)               
    mailServer.ehlo()
    mailServer.starttls()
    mailServer.ehlo()
    mailServer.login(sender, password)
    mailServer.sendmail(sender, recipients, msg.as_string())
    mailServer.quit()

send_mail(sender, recipients, subject, msg.as_string())