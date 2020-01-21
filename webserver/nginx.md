## Nginx配置文件的整体结构

![](
  ./nginx.webp)

从图中可以看出主要包含以下几大部分内容：

1. 全局块
```
该部分配置主要影响Nginx全局，通常包括下面几个部分：

配置运行Nginx服务器用户（组）

worker process数

Nginx进程PID存放路径

错误日志的存放路径

配置文件的引入
```
2. events块
```
该部分配置主要影响Nginx服务器与用户的网络连接，主要包括：

设置网络连接的序列化

是否允许同时接收多个网络连接

事件驱动模型的选择

最大连接数的配置
```
3. http块
```
定义MIMI-Type

自定义服务日志

允许sendfile方式传输文件

连接超时时间

单连接请求数上限
```
4. server块
```
配置网络监听

基于名称的虚拟主机配置

基于IP的虚拟主机配置
```
5. location块
```
location配置

请求根目录配置

更改location的URI

网站默认首页配置
```

## 配置详解

```
#定义Nginx运行的用户和用户组

user www www;
#nginx进程数，建议设置为等于CPU总核心数。

worker_processes 8;

#全局错误日志定义类型，[ debug | info | notice | warn | error | crit ]

error_log /var/log/nginx/error.log info;

#进程文件

pid /var/run/nginx.pid;

#一个nginx进程打开的最多文件描述符数目，理论值应该是最多打开文件数（系统的值ulimit -n）与nginx进程数相除，但是nginx分配请求并不均匀，所以建议与ulimit -n的值保持一致。

worker_rlimit_nofile 65535;
#工作模式与连接数上限

events

{

#参考事件模型，use [ kqueue | rtsig | epoll | /dev/poll | select | poll ]; epoll模型是Linux 2.6以上版本内核中的高性能网络I/O模型，如果跑在FreeBSD上面，就用kqueue模型。

use epoll;

#单个进程最大连接数（最大连接数=连接数*进程数）

worker_connections 65535;

}

 

#设定http服务器

http
{

include mime.types; #文件扩展名与文件类型映射表

default_type application/octet-stream; #默认文件类型

#charset utf-8; #默认编码

server_names_hash_bucket_size 128; #服务器名字的hash表大小

client_header_buffer_size 32k; #上传文件大小限制

large_client_header_buffers 4 64k; #设定请求缓

client_max_body_size 8m; #设定请求缓

sendfile on; #开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。

autoindex on; #开启目录列表访问，合适下载服务器，默认关闭。

tcp_nopush on; #防止网络阻塞

tcp_nodelay on; #防止网络阻塞

keepalive_timeout 120; #长连接超时时间，单位是秒


#FastCGI相关参数是为了改善网站的性能：减少资源占用，提高访问速度。下面参数看字面意思都能理解。

fastcgi_connect_timeout 300;

fastcgi_send_timeout 300;

fastcgi_read_timeout 300;

fastcgi_buffer_size 64k;

fastcgi_buffers 4 64k;

fastcgi_busy_buffers_size 128k;

fastcgi_temp_file_write_size 128k;

 

#gzip模块设置

gzip on; #开启gzip压缩输出

gzip_min_length 1k; #最小压缩文件大小

gzip_buffers 4 16k; #压缩缓冲区

gzip_http_version 1.0; #压缩版本（默认1.1，前端如果是squid2.5请使用1.0）

gzip_comp_level 2; #压缩等级

gzip_types text/plain application/x-javascript text/css application/xml;

#压缩类型，默认就已经包含text/html，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。

gzip_vary on;

#limit_zone crawler $binary_remote_addr 10m; #开启限制IP连接数的时候需要使用

 

upstream blog.ha97.com {

#upstream的负载均衡，weight是权重，可以根据机器配置定义权重。weigth参数表示权值，权值越高被分配到的几率越大。

server 192.168.80.121:80 weight=3;
server 192.168.80.122:80 weight=2;
server 192.168.80.123:80 weight=3;
}

#虚拟主机的配置

server

{

    #监听端口

    listen 80;

    #域名可以有多个，用空格隔开

    server_name www.ha97.com ha97.com;

    index index.html index.htm index.php;

    root /data/www/ha97;

    location ~ .*\.(php|php5)?$

    {

    fastcgi_pass 127.0.0.1:9000;

    fastcgi_index index.php;

    include fastcgi.conf;

    }

    #图片缓存时间设置

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$

    {

    expires 10d;

    }

    #JS和CSS缓存时间设置

    location ~ .*\.(js|css)?$

    {

    expires 1h;

    }

    #日志格式设定

    log_format access '$remote_addr - $remote_user [$time_local] "$request" '

    '$status $body_bytes_sent "$http_referer" '

    '"$http_user_agent" $http_x_forwarded_for';

    #定义本虚拟主机的访问日志

    access_log /var/log/nginx/ha97access.log access;

    #对 "/" 启用反向代理

    location / {

    proxy_pass http://127.0.0.1:88;

    proxy_redirect off;

    proxy_set_header X-Real-IP $remote_addr;

    #后端的Web服务器可以通过X-Forwarded-For获取用户真实IP

    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    #以下是一些反向代理的配置，可选。

    proxy_set_header Host $host;

    client_max_body_size 10m; #允许客户端请求的最大单文件字节数

    client_body_buffer_size 128k; #缓冲区代理缓冲用户端请求的最大字节数，

    proxy_connect_timeout 90; #nginx跟后端服务器连接超时时间(代理连接超时)

    proxy_send_timeout 90; #后端服务器数据回传时间(代理发送超时)

    proxy_read_timeout 90; #连接成功后，后端服务器响应时间(代理接收超时)

    proxy_buffer_size 4k; #设置代理服务器（nginx）保存用户头信息的缓冲区大小

    proxy_buffers 4 32k; #proxy_buffers缓冲区，网页平均在32k以下的设置

    proxy_busy_buffers_size 64k; #高负荷下缓冲大小（proxy_buffers*2）

    proxy_temp_file_write_size 64k;

    #设定缓存文件夹大小，大于这个值，将从upstream服务器传

    }

    #设定查看Nginx状态的地址

    location /NginxStatus {

    stub_status on;

    access_log on;

    auth_basic "NginxStatus";

    auth_basic_user_file conf/htpasswd;

    #htpasswd文件的内容可以用apache提供的htpasswd工具来产生。

    }

    #本地动静分离反向代理配置

    #所有jsp的页面均交由tomcat或resin处理

    location ~ .(jsp|jspx|do)?$ {

    proxy_set_header Host $host;

    proxy_set_header X-Real-IP $remote_addr;

    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_pass http://127.0.0.1:8080;

    }

    #所有静态文件由nginx直接读取不经过tomcat或resin

    location ~ .*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$

    { expires 15d; }

    location ~ .*.(js|css)?$

    { expires 1h; }

}

}

```

## 开启HTTPS

```
server {
    listen 443;
    server_name ops-coffee.cn;

    ssl on;
    ssl_certificate /etc/nginx/server.crt;
    ssl_certificate_key /etc/nginx/server.key;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;
}
```

ssl on：开启https;
ssl_certificate：配置nginx ssl证书的路径
ssl_certificate_key：配置nginx ssl证书key的路径
ssl_protocols： 指定客户端建立连接时使用的ssl协议版本，如果不需要兼容TSLv1，直接去掉即可
ssl_ciphers： 指定客户端连接时所使用的加密算法，你可以再这里配置更高安全的算法;

## 添加黑白名单
```
location /admin/ {
    allow   192.168.1.0/24;
    deny    all;
}
```
上边表示只允许192.168.1.0/24网段的主机访问，拒绝其他所有。

## 解决跨域
前端项目www.a.com的所有/apis/打头的接口，全部去请求www.b.com
```
server {
        listen       80;
        server_name  www.a.com;
        access_log  logs/test.access.log;
        # 匹配以/apis/开头的请求
        location ^~ /apis/ {
            proxy_pass http://www.b.com;
        }
        location / {
            root html/a;
            index index.html index.htm;
        }
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
```
## nginx负载均衡的5种策略

### 轮询（默认）
```
upstream backserver {
    server 192.168.0.14;
    server 192.168.0.15;
}
```
### weight
```
upstream backserver {
    server 192.168.0.14 weight=3;
    server 192.168.0.15 weight=7;
}
```
### ip_hash
可以解决session的问题
```
upstream backserver {
    ip_hash;
    server 192.168.0.14:88;
    server 192.168.0.15:80;
}
```
### fair（第三方）
按后端服务器的响应时间来分配请求，响应时间短的优先分配。
```
upstream backserver {
    server server1;
    server server2;
    fair;
}
```
### url_hash（第三方）
按访问url的hash结果来分配请求，使每个url定向到同一个（对应的）后端服务器。
```
upstream backserver {
    server squid1:3128;
    server squid2:3128;
    hash $request_uri;
    hash_method crc32;
}
```

