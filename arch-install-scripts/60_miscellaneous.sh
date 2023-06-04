echo Setting timezone to US Eastern \(GMT - 4\)
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
echo Setting hardware clock...
hwclock --systohc

echo enabling wheel group for sudo...
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf

echo You must set the host name. vim /etc/hostname
