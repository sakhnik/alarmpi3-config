IgnorePath '/etc/firewalld/*.old'
IgnorePath '/etc/firewalld/**/*.old'

AddPackage firewalld # Firewall daemon with D-Bus interface

CreateLink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service /usr/lib/systemd/system/firewalld.service
CreateLink /etc/systemd/system/multi-user.target.wants/firewalld.service /usr/lib/systemd/system/firewalld.service

GetPackageOriginalFile firewalld /etc/firewalld/firewalld.conf >/dev/null

CopyFile /etc/firewalld/lockdown-whitelist.xml
CopyFile /etc/firewalld/policies/allow-host-ipv6.xml
CopyFile /etc/firewalld/zones/block.xml
CopyFile /etc/firewalld/zones/dmz.xml
CopyFile /etc/firewalld/zones/drop.xml
CopyFile /etc/firewalld/zones/external.xml
CopyFile /etc/firewalld/zones/home.xml
CopyFile /etc/firewalld/zones/internal.xml
CopyFile /etc/firewalld/zones/public.xml
CopyFile /etc/firewalld/zones/trusted.xml
CopyFile /etc/firewalld/zones/work.xml
