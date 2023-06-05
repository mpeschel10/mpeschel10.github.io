[ -z "$MOUNTPOINT" ] && MOUNTPOINT=/mnt

export MOUNTPOINT
sudo sh -c "genfstab -U '$MOUNTPOINT' >> '$MOUNTPOINT/etc/fstab'"

echo Doing arch-chroot into /mnt.
echo Next script should be /home/mpeschel/projects/migration/install_scripts/60_miscellaneous.sh
sudo arch-chroot "$MOUNTPOINT"
