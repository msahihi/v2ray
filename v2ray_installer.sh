#!/bin/bash

V2RAY_CORE_URL="https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh"
V2RAY_GEOIP="https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh"
XUI_URL="https://raw.githubusercontent.com/hossinasaadi/x-ui/master/install.sh"

export PATH=$PATH:/usr/bin
sudo apt update

echo -e '\nInstall v2ray Core'
curl "${V2RAY_CORE_URL}" --output install-release.sh
chmod +x install-release.sh && ./install-release.sh

echo -e '\nInstall geoip.dat and geosite.dat'
curl "${V2RAY_GEOIP}" --output install-dat-release.sh
chmod +x install-dat-release.sh && ./install-dat-release.sh
systemctl enable v2ray
service v2ray start

echo -e '\nInstall x-ui'
curl "${XUI_URL}" --output x-ui-install.sh
chmod +x x-ui-install.sh
yes no | ./x-ui-install.sh
