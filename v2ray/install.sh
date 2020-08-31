#!/bin/bash
set -e

echo "开始安装"
yum install -y nginx
systemctl start nginx.service
systemctl enable nginx.service
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload

curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh
bash install-release.sh
bash install-dat-release.sh
systemctl start v2ray.service
systemctl enable v2ray.service
