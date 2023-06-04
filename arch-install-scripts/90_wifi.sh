echo Starting NetworkManager service...
systemctl enable --now NetworkManager

echo To connect, do
echo nmcli device wifi connect Fios-17J7G password xxxx

