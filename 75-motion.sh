AddPackage motion # Monitor and record video signals from many types of cameras

CopyFile /etc/motion/mail-pic.py 755
CopyFile /etc/motion/mail-video.py 755
CopyFile /etc/motion/motion.conf
DecryptFileTo /etc/motion/params.py.gpg /etc/motion/params.py
