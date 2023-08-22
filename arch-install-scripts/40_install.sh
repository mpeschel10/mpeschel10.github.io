action="$1"
if [ ! -z "$SUZERAIN_CLEAN" ] ; then
    action="clean"
else
    MOUNTPOINT=/mnt
fi

packages="base linux linux-firmware networkmanager"
if [ "$action" = clean ]; then
    packages="${packages} python"
else
    packages="${packages} efibootmgr sudo man man-db rsync git base-devel"
    if [[ "$action" = desktop || "$action" = "machine learning" ]]; then
        packages="${packages} gvim python python-pip firefox keepassxc discord gnome gdm libreoffice dust vscode"
        if [ "$action" = "machine learning" ]; then
            packages="${packages} gcc hip-runtime-amd"
        fi
    elif [ "$action" = "headless" ]; then
        packages="${packages} vim openssh"
    else
        echo "You must provide an argument from ('desktop' 'machine learning' 'headless' 'clean')."
        exit 1
    fi
fi
sudo pacstrap -K "$MOUNTPOINT" $packages

if [[ ! -f /mnt/bin/vi && -f /mnt/bin/vim ]]; then
	echo Making symbolic link from /mnt/bin/vi to /mnt/bin/vim...
	ln -s /mnt/bin/vim /mnt/bin/vi
fi

echo Packages installed.
INSTALL_SCRIPTS_DIR="$MOUNTPOINT/home/mpeschel/projects/migration/install_scripts"
echo Copying /install scripts to "$INSTALL_SCRIPTS_DIR"...
sudo mkdir --parents "$INSTALL_SCRIPTS_DIR"
sudo cp -rv "$SCRIPTS_DIR"/* "$INSTALL_SCRIPTS_DIR"

