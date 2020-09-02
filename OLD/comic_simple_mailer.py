#!/usr/bin/python

import smtplib
from mailer import Mailer
from mailer import Message

import comicdeliverer_at_gmail_settings
import comics_email_text

# grabs settings from comicdeliverer_at_gmail_settings
sender = comicdeliverer_at_gmail_settings.sender
recipients = comicdeliverer_at_gmail_settings.recipients
password = comicdeliverer_at_gmail_settings.password
smtp = comicdeliverer_at_gmail_settings.smtp 
port = comicdeliverer_at_gmail_settings.port 

#grabs text from comics_email_text
plain_text = comics_email_text.plain_text
html_text = comics_email_text.html_text
subject = comics_email_text.subject 

# accesses server
mailServer = smtplib.SMTP(smtp, port)               
mailServer.ehlo()
mailServer.starttls()
mailServer.ehlo()
mailServer.login(sender, password)

message = Message(From = sender,
                  To = recipients,
                  charset="utf-8")
message.Subject = subject
message.Html = html_text

message.Body = plain_text

sender = Mailer(smtp, port)
sender.send(message)