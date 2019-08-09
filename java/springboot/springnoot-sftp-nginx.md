## springboot上传到sftp服务器并使用nginx代理文件

### nginx 代理图片

```
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

