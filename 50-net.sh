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
