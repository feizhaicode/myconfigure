#!/bin/bash
file=/usr/local/etc/v2ray/config.json
echo "configureFile=$file"
echo "Select:"
echo "1.create new user"
read select
if [ $select == 1 ];then
	uuid=`/usr/local/bin/v2ctl uuid`
	sed -i '/"clients"/a\{"id": "'$uuid'","alterId": 0}' $file	
	echo "done"
else
	echo "Not found:$select"
	
fi
