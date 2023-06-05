export SUZERAIN_CLEAN=1
export CLEAN_BOOT_PART=/dev/nvme0n1p3
export CLEAN_HOME_PART=/dev/nvme0n1p4
MOUNTPOINT=`pwd`/mnt

if [ ! -d "$MOUNTPOINT" ]; then
    MOUNTPOINT=`pwd`/../mnt
    MOUNTPOINT=`realpath -L $MOUNTPOINT`
fi

if [ ! -d "$MOUNTPOINT" ]; then
    echo Could not find ./mnt or ../mnt.
    echo Please make the mount directory or fix my janky code to continue.
    exit 2
fi
export MOUNTPOINT

SCRIPTS_DIR=`pwd`
[ -d "$SCRIPTS_DIR/install_scripts" ] && SCRIPTS_DIR="$SCRIPTS_DIR/install_scripts"
echo Please confirm SCRITPS_DIR IS correct
export SCRIPTS_DIR

