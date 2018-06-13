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
