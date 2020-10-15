AddPackage archlinux-keyring # Arch Linux PGP keyring
AddPackage fakeroot # Tool for simulating superuser privileges
AddPackage pacman # A library-based package manager with dependency support
AddPackage pacman-contrib # Contributed scripts and tools for pacman systems
AddPackage pacman-mirrorlist # Arch Linux ARM mirror list for use by pacman
AddPackage pacutils # Helper tools for libalpm
AddPackage pkgconf # Package compiler and linker metadata toolkit
AddPackage vifm # A file manager with curses interface, which provides Vi[m]-like environment
AddPackage yajl # Yet Another JSON Library

AddPackage aurutils # helper tools for the arch user repository


cat >"$(CreateFile /etc/pacman.d/hooks/paccache-remove.hook)" <<EOF
[Trigger]
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -ruk0
EOF

cat >"$(CreateFile /etc/pacman.d/hooks/paccache-upgrade.hook)" <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -rk2
EOF

sed -i -f - "$(GetPackageOriginalFile pacman-mirrorlist /etc/pacman.d/mirrorlist)" <<'EOF'
7 s|Server = .*|Server = http://de.mirror.archlinuxarm.org/$arch/$repo|
EOF

sed -i -f - "$(GetPackageOriginalFile pacman /etc/pacman.conf)" <<EOF
/^#Color/ s/^#//
/^#TotalDownload/ s/^#//
/^#CheckSpace/ s/^#//
/^#VerbosePkgLists/ s/^#//
/VerbosePkgLists/ a ILoveCandy
/^#CacheDir/ s/^#//
/^CacheDir/ a\CacheDir    = /var/cache/pacman/custom/
/#\[custom\]/,+2 s/^#//
EOF
