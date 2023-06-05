echo Confirming network connection.
ping -c 2 archlinux.org && echo Network ok # Failure should terminate the script

if [ -z "$SUZERAIN_CLEAN" ]; then
    echo Updating local keyring.
    pacman -Sy
    pacman -S archlinux-keyring || echo "You must run pacman -S archlinux-keyring manually."
else
    echo Skipping keyring update for clean suzerain install.
fi

echo You must partition the disks yourself.
echo Mount one partition as root: /mnt \(mkfs.ext4\)
echo Mount one partition as boot: /mnt/boot \(mkfs.fat -F 32\)
echo Align one partition as swap: swapon /dev/sdxn
echo You can also call: ./30_wipe_and_part.sh /dev/sdx # to use the entire /dev/sdx drive

echo "               or: ./30_suzerain_clean.sh"

