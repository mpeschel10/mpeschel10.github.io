echo Starting NetworkManager service...
systemctl enable --now NetworkManager

echo To connect, do
echo nmcli device wifi connect SSID password xxxx

