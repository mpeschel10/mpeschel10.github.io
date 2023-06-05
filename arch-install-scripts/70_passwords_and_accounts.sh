echo Creating mpeschel user account\; member of group wheel...
useradd mpeschel
usermod -a -G wheel mpeschel

echo Set the password for mpeschel:
passwd mpeschel
