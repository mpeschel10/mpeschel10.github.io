if test -z "$1"; then
    echo You must provide the device of the drive as an argument.
    exit 1
fi
echo This script will erase and reformat the drive you gave it as argument.
echo This operation will result in data loss on the entire drive.
echo It will also prevent any operating system which uses that drive as a boot loader from booting.
echo Targeting drive \'"$1"\'
echo Press enter to continue\; ctrl + c to abort.
read 

echo Erasing partition table and signatures from drive "$1"...
wipefs -a "$1"?* # Erase filesystem signatures. If you don't do this, fdisk will become confused.
wipefs -a "$1"

echo Making new partitions...
(
 echo g;                    # GPT partition table
 echo -e 'n\n\n\n+2G';      # First partition 2 Gb
 echo -e 't\n\n1';          # Type is EFI System
 echo -e 'n\n\n\n-10G';     # Second partition all but last 10 Gb
 echo -e 'n\n\n\n';         # Third partition remainder of drive (10 Gb)
 echo -e 't\n\n19';         # Type is Swap
 echo p; echo w             # Print partition table, write and exit.
) | fdisk "$1"

echo Making filesystems...
suffix=$(test -b "${1}1" && echo "" ||  # Normal drive e.g. /dev/sdb3
	echo $(test -b "${1}p1" && echo p || # NVME drive e.g. /dev/nvme0n1p2
	$(echo "Cannot identify drive suffix; you have to make filesystems and mount them yourself"; exit 2) )
)
mkfs.fat -F 32 "${1}${suffix}1"
mkfs.ext4 "${1}${suffix}2"
mkswap "${1}${suffix}3"

echo Mounting partitions...
mount "${1}${suffix}2" /mnt
mount --mkdir "${1}${suffix}1" /mnt/boot
swapon "${1}${suffix}3"

echo Labeling partitions...
fatlabel "${1}${suffix}1" BOOT
e2label "${1}${suffix}2" HOME
echo "Partition script is done; please run next script."

