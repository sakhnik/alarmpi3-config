
AddPackage lighttpd # A secure, fast, compliant and very flexible web-server
CreateLink /etc/systemd/system/multi-user.target.wants/lighttpd.service /usr/lib/systemd/system/lighttpd.service

CopyFile /etc/lighttpd/lighttpd.conf


AddPackage php-fpm # FastCGI Process Manager for PHP
CreateLink /etc/systemd/system/multi-user.target.wants/php-fpm.service /usr/lib/systemd/system/php-fpm.service

sed -i -f - "$(GetPackageOriginalFile php /etc/php/php.ini)" <<EOF
/^;extension=gd/ s/^;//
EOF


AddPackage dokuwiki # Simple to use and highly versatile Open Source wiki software

CopyFile /etc/webapps/dokuwiki/acl.auth.php '' http http
CopyFile /etc/webapps/dokuwiki/local.php '' http http
CopyFile /etc/webapps/dokuwiki/plugins.local.php '' http http
DecryptFileTo /etc/webapps/dokuwiki/users.auth.php.gpg /etc/webapps/dokuwiki/users.auth.php
SetFileProperty /etc/webapps/dokuwiki/users.auth.php group http
SetFileProperty /etc/webapps/dokuwiki/users.auth.php owner http
