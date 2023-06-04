packages="base linux linux-firmware efibootmgr networkmanager sudo man man-db rsync git base-devel"
if test "$1" = "desktop" || test "$1" = "machine learning"; then
	packages="${packages} gvim python python-pip firefox keepassxc discord gnome gdm libreoffice dust vscode"
	if test "$1" = "machine learning"; then
		packages="${packages} gcc hip-runtime-amd"
	fi
elif test "$1" = "headless"; then
	packages="${packages} vim openssh"
else
	echo "You must provide an argument from ('desktop' 'machine learning' 'headless')."
	exit 1
fi
pacstrap -K /mnt $packages

if [ ! -f /mnt/bin/vi ]; then
	echo Making symbolic link from /mnt/bin/vi to /mnt/bin/vim...
	ln -s /mnt/bin/vim /mnt/bin/vi
fi

echo Packages installed.
echo Copying /install files to /mnt/home/mpeschel/projects/migration/install_scripts...
mkdir --parents /mnt/home/mpeschel/projects/migration/install_scripts
cp -v /install_scripts/* /mnt/home/mpeschel/projects/migration/install_scripts

