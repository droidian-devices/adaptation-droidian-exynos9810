#!/bin/bash
# on exynos 9810 chipset, bt address comes from /mnt/vendor/efs/bluetooth/bt_addr

if [ -f "/mnt/vendor/efs/bluetooth/bt_addr" ]; then
    echo $(cat /mnt/vendor/efs/bluetooth/bt_addr) > /var/lib/bluetooth/board-address
else
    touch /var/lib/bluetooth/board-address
fi
