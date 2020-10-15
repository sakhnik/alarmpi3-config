#!/usr/bin/env python3

import params

import mimetypes
import sys, os
import smtplib

# Here are the email package modules we'll need
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email import encoders

fname=sys.argv[1]

# Create the container (outer) email message.
msg = MIMEMultipart()
msg['Subject'] = 'Motion cam1'
# me == the sender's email address
# family = the list of all recipients' email addresses
msg['From'] = params.from_email
msg['To'] = params.to_email
#msg.preamble = JSON

try:
    mime_type = mimetypes.guess_type(fname)[0].split('/')
except:
    if fname.endswith('.mkv'):
        mime_type = ['video', 'x-matroska']
    else:
        raise

# Open the files in binary mode.  Let the MIMEImage class automatically
# guess the specific image type.
part = MIMEBase(mime_type[0], mime_type[1])
with open(fname, 'rb') as fp:
    part.set_payload(fp.read())
part['Content-Disposition'] = f'attachment; filename="{os.path.basename(fname)}"'
encoders.encode_base64(part)
msg.attach(part)

# Send the email via our own SMTP server.
with smtplib.SMTP_SSL(params.smtp_addr, params.smtp_port) as s:
    s.login(params.from_email, params.password)
    s.send_message(msg)

print("Sending email")
