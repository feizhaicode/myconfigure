#!/bin/bash
file=/usr/local/etc/v2ray/config.json
echo "configureFile=$file"
echo "Select:"
echo "1.create new user"
read select
if [ $select == 1 ];then
	echo "select a port:"
#grep 找到"port":那一行 ,awk 使用 :和, 分割打印第二个
	cat $file|grep "\"port\":" |awk -F '[:,]' '{print $2}'
	read num
	uuid=`/usr/local/bin/v2ctl uuid`
	sed -i '/"port": '$num'/a\{"id": "'$uuid'","alterId": 0}' $file	
else
	echo "Not found:$select"
	
fi
