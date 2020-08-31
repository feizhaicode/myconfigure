#!/bin/bash
NginxFilePath=/etc/nginx/conf.d/default.conf.tmp
v2rayFilePath=/usr/local/etc/v2ray/config.json.tmp

echo "enter Host:"
read host


if [ ! -f $NginxFilePath ];then
	echo "set \$host $host">>$NginxFilePath
cat <<done>>$NginxFilePath
  server {
        listen       80;
        server_name  \$host;
	rewrite ^(.*) https://$server_name$1 permanent;
}
    server {
        listen       443 ssl http2;
        server_name  \$host;
        root         /usr/share/nginx/html;
		charset utf-8;
        location / {
		index  index.html;
        }
	location /sync {
		proxy_redirect off;
		proxy_pass http://127.0.0.1:35861;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
	       	proxy_set_header Connection "upgrade";
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
    access_log  /var/log/nginx/feizhai.access.log;
    error_log /var/log/nginx/feizhai.error.log;
    }
done
else
		echo "$NginxFilePath:File exists"
	fi
	
if [ ! -f $v2rayFilePath ];then
cat <<done>>$v2rayFilePath

{
	"log":{
		"loglevel":"warning",
		"access": "/var/log/v2ray/access.log",
		"error": "/var/log/v2ray/error.log"
	},
  "inbounds": [
    
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
done
else
		echo "$v2rayFilePath:File exists"
	fi
