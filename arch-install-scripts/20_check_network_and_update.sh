echo Confirming network connection.
ping -c 2 archlinux.org && echo Network ok # Failure should terminate the script

echo Updating local keyring.
pacman -Sy
pacman -S archlinux-keyring || echo "YOU MUST RUN pacman -S archlinux-keyring MANUALLY. WHY DOES THIS NOT WORK. I DON'T KNOW."

echo You must partition the disks yourself.
echo Mount one partition as root: /mnt \(mkfs.ext4\)
echo Mount one partition as boot: /mnt/boot \(mkfs.fat -F 32\)
echo Align one partition as swap: swapon /dev/sdxn
echo You can also call: ./30_wipe_and_part.sh /dev/sdx # to use the entire /dev/sdx drive

