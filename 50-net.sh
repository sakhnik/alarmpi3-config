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


AddPackage postfix # Fast, easy to administer, secure mail server
AddPackage s-nail # Mail processing system with a command syntax reminiscent of ed
CreateLink /etc/systemd/system/multi-user.target.wants/postfix.service /usr/lib/systemd/system/postfix.service

AddPackage nfs-utils # Support programs for Network File Systems
CreateLink /etc/systemd/system/multi-user.target.wants/nfs-server.service /usr/lib/systemd/system/nfs-server.service
CreateDir /srv/nfs4/data
cat >>"$(GetPackageOriginalFile nfs-utils /etc/exports)" <<EOF

/srv/nfs4               *(ro,sync,fsid=0)
/srv/nfs4/data          192.168.13.0/24(rw,sync,nohide)
EOF


AddPackage tinc # VPN (Virtual Private Network) daemon
CreateLink /etc/systemd/system/multi-user.target.wants/tinc.service /usr/lib/systemd/system/tinc.service

# Tinc network home
CreateLink /etc/systemd/system/tinc.service.wants/tinc@home.service /usr/lib/systemd/system/tinc@.service

cat >"$(CreateFile /etc/tinc/home/tinc.conf)" <<EOF
Name = alarmpi3
AddressFamily = ipv4
Device = /dev/net/tun
EOF

cat >"$(CreateFile /etc/tinc/home/tinc-up 755)" <<'EOF'
#!/bin/sh

ifconfig $INTERFACE 10.0.1.1 netmask 255.255.255.0
EOF

cat >"$(CreateFile /etc/tinc/home/tinc-down 755)" <<'EOF'
#!/bin/sh

ifconfig $INTERFACE down
EOF

CopyFile /etc/tinc/home/hosts/alarmpi3
CopyFile /etc/tinc/home/hosts/kionia
CopyFile /etc/tinc/home/hosts/land
CopyFile /etc/tinc/home/hosts/potter
DecryptFileTo /etc/tinc/home/rsa_key.priv.gpg /etc/tinc/home/rsa_key.priv
SetFileProperty /etc/tinc/home/rsa_key.priv mode 600

# Tinc network farm
CreateLink /etc/systemd/system/tinc.service.wants/tinc@farm.service /usr/lib/systemd/system/tinc@.service

cat >"$(CreateFile /etc/tinc/farm/tinc.conf)" <<EOF
Name = alarmpi3
AddressFamily = ipv4
Device = /dev/net/tun
EOF

cat >"$(CreateFile /etc/tinc/farm/tinc-up 755)" <<'EOF'
#!/bin/sh

ifconfig $INTERFACE 10.0.2.1 netmask 255.255.255.0
EOF

cat >"$(CreateFile /etc/tinc/farm/tinc-down 755)" <<'EOF'
#!/bin/sh

ifconfig $INTERFACE down
EOF

CopyFile /etc/tinc/farm/hosts/alarmpi3
CopyFile /etc/tinc/farm/hosts/kionia
CopyFile /etc/tinc/farm/hosts/pangea
DecryptFileTo /etc/tinc/farm/rsa_key.priv.gpg /etc/tinc/farm/rsa_key.priv
SetFileProperty /etc/tinc/farm/rsa_key.priv mode 600
