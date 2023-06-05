
[ -d /mnt/install_scripts ] && script_dir="/mnt/install_scripts"
[ -d /install_scripts/install_scripts ] && script_dir="/install_scripts/install_scripts"

if [ -f /etc/hostname ] ; then
    echo Is this an already installed system? You don\'t need to run 05_copy_and_eject.
    exit 0
fi

if [ -z "$script_dir" ] ; then
    echo "You must copy the install scripts from the directory where you mounted them,"
    echo " then unmount the drive so it doesn't get added to fstab."
    exit 2
fi

echo Copying files from "$script_dir" to /install_scripts...
[ -d /install_scripts ] || mkdir /install_scripts
cp -v "${script_dir}/*" /install_scripts
echo You must unmount the install script drive so it doesn\'t get added to fstab.
