# Docker安装Mysql
## 安装版本5.6
```
docker run -p 53306:3306 -v $PWD/mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql56 -d mysql:5.6
```
将容器数据目录 /var/lib/mysql 挂载到主机的/mysqldata。

## 升级到5.7
```
docker run -p 63306:3306 -v $PWD/mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql57 -d mysql:5.7
```
创建容器 同样挂载到原本的目录: /mysqldata


问题1：

升级到8.0无法启动.原因：/mysqldata下面的插件文件是5.6版本创建的 8.0无法启动。

解决办法：

用新的8.0启动一个新的mysql 容器，挂接一个任意目录。然后通过navicat等其他工具将老的数据备份还原到新的mysql容器中。

问题2:

远程连接报错

ERROR 2059 (HY000): Authentication plugin 'caching_sha2_password' cannot be loaded: ÕÒ²»µ½Ö¸¶¨µÄÄ£¿é¡£

那么你需要修改mysql 的 my.cnf 文件：
添加：
```
default_authentication_plugin=mysql_native_password
```

