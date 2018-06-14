AddPackage samba # SMB Fileserver and AD Domain server

CopyFile /etc/samba/smb.conf

CreateLink /etc/systemd/system/multi-user.target.wants/nmb.service /usr/lib/systemd/system/nmb.service
CreateLink /etc/systemd/system/multi-user.target.wants/smb.service /usr/lib/systemd/system/smb.service

cat >"$(CreateFile /etc/sysctl.d/30-ipforward.conf)" <<EOF
net.ipv4.ip_forward=1
net.ipv6.conf.default.forwarding=1
net.ipv6.conf.all.forwarding=1
EOF

AddPackage openssh # Free version of the SSH connectivity tools
IgnorePath '/etc/ssh/ssh_host_*'

sed -i -f - "$(GetPackageOriginalFile openssh /etc/ssh/sshd_config)" <<EOF
/^#GatewayPorts/ s/^.*$/GatewayPorts clientspecified/
EOF

CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service

CreateFile /etc/iptables/iptables.rules > /dev/null
CreateLink /etc/systemd/system/multi-user.target.wants/iptables.service /usr/lib/systemd/system/iptables.service

AddPackage avahi # Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour
CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket


AddPackage nginx # Lightweight HTTP server and IMAP/POP3 proxy server
CopyFile /etc/nginx/nginx.conf
CreateLink /etc/systemd/system/multi-user.target.wants/nginx.service /usr/lib/systemd/system/nginx.service
sed -i -f - "$(GetPackageOriginalFile mailcap /etc/nginx/mime.types)" <<EOF
EOF
