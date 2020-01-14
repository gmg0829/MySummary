## 前端vue 部署
### jemkins
![](
  ./build-fore.jpg) 

![](
  ./build-back.jpg)   
 
### nginx
```
server {
        listen    8888;
        server_name  localhost;
        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            try_files $uri /200.html;
            root /root/showVisual/dist;
            index  200.html 200.htm;

        }

}    
server{
    listen    7979;
    server_name  localhost;
    #charset koi8-r;

    #access_log  logs/host.access.log  main;

    location ~ .*\.(gif|jpg|jpeg|bmp|png|ico)$ {
        root /file;
        autoindex on;
    }
}
```
## 后端部署
![](
  ./java-jenkins.jpg)  

### nginx
```
 upstream amljob {
    server 192.168.1.166:9999;
    server 192.168.1.166:9990;
}
server{
    listen    8088;
    server_name  localhost;
    #charset koi8-r;

    #access_log  logs/host.access.log  main;

    location /job-admin {
        proxy_pass http://amljob/job-admin;
    }
}
```