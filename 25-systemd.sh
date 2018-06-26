AddPackage netctl # Profile based systemd network management
AddPackage systemd-sysvcompat # sysvinit compat for systemd

CreateLink /etc/resolv.conf /run/systemd/resolve/resolv.conf
SetFileProperty /etc/resolv.conf mode 777

CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service

cat >"$(CreateFile /etc/systemd/journald.conf.d/00-journal-size.conf)" <<EOF
[Journal]
SystemMaxUse=50M
EOF

cat >"$(CreateFile /etc/systemd/network/eth0.network)" <<EOF
[Match]
Name=eth0

[Network]
DHCP=yes
EOF

# Launch raspbian in a container for kerberosio
CopyFile /etc/systemd/nspawn/raspbian.nspawn
CreateLink /etc/systemd/system/machines.target.wants/systemd-nspawn@raspbian.service /usr/lib/systemd/system/systemd-nspawn@.service
CreateLink /etc/systemd/system/multi-user.target.wants/machines.target /usr/lib/systemd/system/machines.target
CopyFile /etc/systemd/system/systemd-nspawn@raspbian.service.d/override.conf

# Kerberosio in the Raspbian
IgnorePath '/etc/opt/kerberosio/logs/*'

CopyFile /etc/opt/kerberosio/config/algorithm.xml 777
CopyFile /etc/opt/kerberosio/config/capture.xml 777
CopyFile /etc/opt/kerberosio/config/cloud.xml 777
CopyFile /etc/opt/kerberosio/config/condition.xml 777
CopyFile /etc/opt/kerberosio/config/config.xml 777
CopyFile /etc/opt/kerberosio/config/expositor.xml 777
CopyFile /etc/opt/kerberosio/config/heuristic.xml 777
CopyFile /etc/opt/kerberosio/config/io.xml 777
CopyFile /etc/opt/kerberosio/config/stream.xml 777
IgnorePath '/etc/opt/kerberosio/scripts/run.sh'
CopyFile /etc/opt/kerberosio/scripts/email.sh 755
CopyFile /etc/opt/kerberosio/scripts/mail.py
CreateDir /etc/opt/kerberosio/h264 777
CreateDir /etc/opt/kerberosio/symbols 777
