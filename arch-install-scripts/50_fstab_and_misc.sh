genfstab -U /mnt >> /mnt/etc/fstab
echo Doing arch-chroot into /mnt.
echo Next script should be /home/mpeschel/projects/migration/install_scripts/60_miscellaneous.sh
arch-chroot /mnt
