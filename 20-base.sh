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
