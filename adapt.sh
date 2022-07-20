#!/bin/sh
echo "Adaptation for crownlte devices"
echo "Made by Kreato"
umount /mnt/
mount /data/rootfs.img /mnt/
cd overlay
tar -czf overlay.tar *
tar -hxvf overlay.tar -C /mnt/
rm overlay.tar
chroot /mnt/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin" && systemctl mask systemd-resolved systemd-timesyncd && systemctl enable upower samsung-hwc && dpkg -i /tmp/debs/*.deb && rm -rf /tmp/debs && apt-mark hold libwlroots7c && sed -i "/^_apt/d" /etc/passwd'
umount /mnt/
echo "Done!"
echo "It is recommended to run these command once Droidian is booted;"
echo "sudo apt update && sudo apt upgrade && sudo apt dist-upgrade"
