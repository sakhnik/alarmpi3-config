AddPackage bash # The GNU Bourne Again shell
AddPackage bash-completion # Programmable completion for the bash shell
AddPackage coreutils # The basic file, shell and text manipulation utilities of the GNU operating system
AddPackage device-mapper # Device mapper userspace library and tools
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage f2fs-tools # Tools for Flash-Friendly File System (F2FS)
AddPackage file # File type identification utility
AddPackage filesystem # Base Arch Linux files
AddPackage findutils # GNU utilities to locate files
AddPackage flex # A tool for generating text-scanning programs
AddPackage freetype2 # Font rasterization library
AddPackage glibc # GNU C Library
AddPackage grep # A string search utility
AddPackage gzip # GNU compression utility
AddPackage haveged # Entropy harvesting daemon using CPU timings
AddPackage inetutils # A collection of common network programs
AddPackage iproute2 # IP Routing Utilities
AddPackage iputils # Network monitoring tools, including ping
AddPackage jfsutils # JFS filesystem utilities
AddPackage less # A terminal based program for viewing text files
AddPackage libpng12 # A collection of routines used to create PNG format graphics files
AddPackage licenses # Standard licenses distribution package
AddPackage linux-firmware # Firmware files for Linux
AddPackage linux-raspberrypi # The Linux Kernel and modules - Raspberry Pi
AddPackage logrotate # Rotates system logs automatically
AddPackage lvm2 # Logical Volume Manager 2 utilities
AddPackage mdadm # A tool for managing/monitoring Linux md device arrays, also known as Software RAID
AddPackage net-tools # Configuration tools for Linux networking
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage procps-ng # Utilities for monitoring your system and its processes
AddPackage psmisc # Miscellaneous procfs tools
AddPackage python # Next generation of the python high-level scripting language
AddPackage raspberrypi-bootloader # Bootloader files for Raspberry Pi
AddPackage raspberrypi-bootloader-x # Bootloader with extra codecs for Raspberry Pi
AddPackage raspberrypi-firmware # Firmware tools, libraries, and headers for Raspberry Pi
AddPackage reiserfsprogs # Reiserfs utilities
AddPackage sed # GNU stream editor
AddPackage shadow # Password and account management tool suite with support for shadow files and PAM
AddPackage sysfsutils # System Utilities Based on Sysfs
AddPackage tar # Utility used to store, backup, and transport files
AddPackage texinfo # GNU documentation system for on-line information and printed output
AddPackage util-linux # Miscellaneous system utilities for Linux
AddPackage wireless_tools # Tools allowing to manipulate the Wireless Extensions
AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
AddPackage xfsprogs # XFS filesystem utilities


CreateLink /etc/os-release ../usr/lib/os-release


cat >"$(CreateFile /etc/vconsole.conf)" <<EOF
FONT=LatArCyrHeb-16+
EOF

cat >"$(CreateFile /etc/hostname)" <<EOF
alarmpi3
EOF

cat >"$(CreateFile /etc/locale.conf)" <<EOF
LANG=uk_UA.UTF-8
EOF

# Specify locales
f="$(GetPackageOriginalFile glibc /etc/locale.gen)"
sed -i 's/^#\(en_US.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(uk_UA.UTF-8\)/\1/g' "$f" # for ISO timestamps

cat >"$(CreateFile /etc/motd)" <<EOF
Welcome to Arch Linux ARM

     Website: http://archlinuxarm.org
       Forum: http://archlinuxarm.org/forum
         IRC: #archlinux-arm on irc.Freenode.net
EOF

CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Kiev

cat >"$(CreateFile /etc/hosts)" <<EOF
# Static table lookup for hostnames.
# See hosts(5) for details.

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost.localdomain	localhost
127.0.1.1	alarmpi3.localdomain	alarmpi3
::1		localhost.localdomain	localhost

# End of file
EOF

CreateLink /opt/fsl/lib/libGAL_egl.so libGAL_egl.dri.so

cat >"$(CreateFile /etc/udev/rules.d/raspberrypi.rules)" <<EOF
SUBSYSTEM=="vchiq|input", MODE="0777"
KERNEL=="mouse*|mice|event*",  MODE="0777"
EOF

CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/haveged.service /usr/lib/systemd/system/haveged.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket


IgnorePath '/etc/.updated'
CopyFile /etc/fstab
CopyFile /etc/shells
