IgnorePath '/etc/opt/kerberosio/logs/*'

AddPackage --foreign ffmpeg2.8 # Complete solution to record, convert and stream audio and video
AddPackage --foreign kerberosio-machinery # An image processing framework, which uses your USB-, IP- or RPi-camera to recognize events (e.g. motion).
AddPackage --foreign kerberosio-web # Kerberos.io machinery

CopyFile /etc/opt/kerberosio/config/capture.xml
CopyFile /etc/opt/kerberosio/config/cloud.xml
CopyFile /etc/opt/kerberosio/config/condition.xml
CopyFile /etc/opt/kerberosio/config/config.xml
CopyFile /etc/opt/kerberosio/config/expositor.xml
CopyFile /etc/opt/kerberosio/config/io.xml
CopyFile /etc/opt/kerberosio/config/stream.xml
CopyFile /etc/opt/kerberosio/scripts/email.sh 755 sakhnik users
CopyFile /etc/opt/kerberosio/scripts/mail.py
DecryptFileTo /srv/http/kerberos/config/kerberos.php.gpg /srv/http/kerberos/config/kerberos.php

CreateLink /etc/systemd/system/multi-user.target.wants/kerberosio.service /etc/systemd/system/kerberosio.service
