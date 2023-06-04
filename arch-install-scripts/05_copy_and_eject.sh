
[ -d /mnt/install_scripts ] && script_dir="/mnt/install_scripts"
[ -d /install_scripts/install_scripts ] && script_dir="/install_scripts/install_scripts"
if [ -z "$script_dir" ] ; then
    echo "You must copy the install scripts from the directory where you mounted them,"
    echo " then unmount the drive so it doesn't get added to fstab."
    exit 1
fi

echo Copying files from "$script_dir" to /install_scripts...
[ -d /install_scripts ] || mkdir /install_scripts
cp -v "${script_dir}/*" /install_scripts
echo You must unmount the install script drive so it doesn\'t get added to fstab.
