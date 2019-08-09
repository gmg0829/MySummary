# nginx 部署vue项目

```
 server {
        listen    7878;
        server_name  localhost;
        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            try_files $uri /index.html;
	        root /root/dataVisual/dist;			
            index  index.html index.htm;
            
        }
 }       
```