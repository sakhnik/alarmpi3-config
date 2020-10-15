#!/usr/bin/env python3

import params

import sys, os
import smtplib

# Here are the email package modules we'll need
from email.mime.image import MIMEImage
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart

fname=sys.argv[1]

# Create the container (outer) email message.
msg = MIMEMultipart()
msg['Subject'] = 'Motion cam1'
# me == the sender's email address
# family = the list of all recipients' email addresses
msg['From'] = params.from_email
msg['To'] = params.to_email
#msg.preamble = JSON

# Open the files in binary mode.  Let the MIMEImage class automatically
# guess the specific image type.
with open(fname, 'rb') as fp:
    part = MIMEImage(fp.read())
part['Content-Disposition'] = 'attachment; filename="%s"' % os.path.basename(fname)
msg.attach(part)

# Send the email via our own SMTP server.
with smtplib.SMTP_SSL(params.smtp_addr, params.smtp_port) as s:
    s.login(params.from_email, params.password)
    s.send_message(msg)

print("Sending email")
