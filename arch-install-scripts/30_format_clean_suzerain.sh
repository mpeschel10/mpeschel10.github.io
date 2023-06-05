if [ -z "$MOUNTPOINT" ] ; then
    echo This script is meant to prepare a fresh install of Arch
    echo " "on a small partition on the \"suzerain\" computer,
    echo " "for confirming dependencies etc.
    echo Run . 02_source_for_clean_suzerain.sh first.
    exit 2
fi

echo This script is meant to prepare a fresh install of Arch
echo " "on a small partition on the \"suzerain\" computer,
echo " "for confirming dependencies etc.
echo It assumes the disk is partitioned and the bootloader is installed\;
echo " "all it does is reformat and mount.
echo It will target $CLEAN_HOME_PART as home and $CLEAN_BOOT_PART as boot.
echo Press enter to continue\; ctrl + c to abort.
read

echo Formatting partition...
sudo mkfs.ext4 "$CLEAN_HOME_PART"

echo Mounting partitions...
sudo mount "$CLEAN_HOME_PART" "$MOUNTPOINT"
sudo mount --mkdir "$CLEAN_BOOT_PART" "${MOUNTPOINT}/boot"

echo Labeling partitions...
sudo e2label "$CLEAN_HOME_PART" CLEAN
echo "Partition script is done; please run next script."

