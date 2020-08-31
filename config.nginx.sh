#!/bin/bash
path=/etc/nginx/conf.d/default.conf.tmp

echo "enter Host:"
read host
echo "set \$host $host">>$path
cat <<done>>$path
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
	location /error01 {
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
