#!/bin/bash
file=/usr/local/etc/v2ray/config.json.tmp
echo "configureFile=$file"
echo "Select:"
echo "1.create new user"
echo "2.create new port"
read select
if [ $select == 1 ];then
	echo "select a port:"
#grep 找到"port":那一行 ,awk 使用 :和, 分割打印第二个
	cat $file|grep "\"port\":" |awk -F '[:,]' '{print $2}'
	read num
	uuid=`/usr/local/bin/v2ctl uuid`
	sed -i '/"port": '$num'/a\{"id": "'$uuid'","alterId": 0}' $file
	
elif [ $select == 2 ];then
	echo "enter port number"
	read num
#找到"inbounds" 在下一行插入新端口配置
	sed -i '/"inbounds"/a\{"port": '$num',"listen": "127.0.0.1", "protocol": "vmess","settings": {"clients": [\n]},' $file
	
else
	echo "Not found:$select"
	
fi
