name="ARCH LINUX"
[ ! -z "$INSTALL_NAME" ] && name="$INSTALL_NAME"

if ! test -z "$3"; then
	root="$1"
	boot_disk="$2"
	boot_partition="$3"
    [ ! -z "$4" ] && name="$4"
else
	if ! test -z "$2" || ! test -z "$1"; then
		echo You must give either all three arguments or none of them.
		exit 1
	fi

	root=$(lsblk -prn -o NAME,MOUNTPOINT | grep -e " /$" | grep -oe "^[^ ]*")

	boot_full=$(lsblk -prn -o NAME,MOUNTPOINT | grep -e " /boot$" | grep -oe "^[^ ]*")
	boot_disk=$(lsblk -prn -o PKNAME,MOUNTPOINT | grep -e " /boot$" | grep -oe "^[^ ]*")
	# This regex might be zsh only. Is it portable?
	boot_partition=${boot_full//${boot_disk}/}
	boot_partition=${boot_partition//p/}

	echo Selected root,boot automatically since not enough arguments were given.
	echo root="$root" and boot_disk="$boot_disk" and boot_partition="$boot_partition". Does this look correct?
	echo Press enter to continue\; press ctrl + c to abort.
	read
fi

echo Writing UEFI boot entry...
efibootmgr --create --disk "$boot_disk" --part  "$boot_partition" --label "$name" --loader /vmlinuz-linux --unicode "root=${root} rw initrd=\initramfs-linux.img"

echo You may want to clean up boot entries\; do
echo efibootmgr --unicode -B -b n
echo where n is the hexadecimal number of the entry to be deleted.
echo
echo After you\'re done, exit with ctrl + d and unmount everything e.g. umount -R /mnt.
echo Then reboot.
