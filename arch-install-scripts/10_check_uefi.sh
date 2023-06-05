#!/bin/sh

echo Checking if in UEFI mode...
ls /sys/firmware/efi/efivars > /dev/null 2> /dev/null && echo UEFI mode ok || echo UEFI mode failure\; you will have to do the boot loader manually.

echo You must connect to internet\; e.g.:
echo iwctl station wlan0 connect SSID
