#!/usr/bin/env python3

# --------------------------------------
# The first parameter is the JSON object
#
# e.g. {"regionCoordinates":[308,250,346,329],"numberOfChanges":194,"timestamp":"1486049622","microseconds":"6-161868","token":344,"pathToImage":"1486049622_6-161868_frontdoor_308-250-346-329_194_344.jpg","instanceName":"frontdoor"}

import sys, os, json
import smtplib

# Here are the email package modules we'll need
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart

JSON=sys.argv[1]
print(JSON)
obj = json.loads(JSON)

# Create the container (outer) email message.
msg = MIMEMultipart()
msg['Subject'] = 'Kerberos ' + obj['instanceName']
# me == the sender's email address
# family = the list of all recipients' email addresses
msg['From'] = 'root@alarmpi3'
msg['To'] = 'sakhnik@gmail.com'
msg.preamble = JSON

# Open the files in binary mode.  Let the MIMEImage class automatically
# guess the specific image type.
fname = os.path.join('/etc/opt/kerberosio/capture', obj["pathToImage"])
with open(fname, 'rb') as fp:
    img = MIMEImage(fp.read())
msg.attach(img)

# Send the email via our own SMTP server.
s = smtplib.SMTP('localhost')
s.send_message(msg)
s.quit()
print("Sending email")
