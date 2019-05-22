## docker api
使用 Docker Restful API 之前需要設定 Docker 步驟如下：

1、编辑docker文件：/usr/lib/systemd/system/docker.service
```
$ vi /usr/lib/systemd/system/docker.service
```
修改ExecStart行为下面内容
```
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock
```
重新加载docker配置
```
systemctl daemon-reload // 1，加载docker守护线程
systemctl restart docker // 2，重启docker
```
### 镜像相关的API
> 前缀 http://ip:2375

1、获取所有镜像
```
GET /images/json
```
2、创建镜像
```
POST /images/create
参数
fromImage:镜像名称
tag:标签
```
3、查看镜像历史
```
GET /images/(name)/history
```
4、搜索镜像
```
GET /images/search
参数
term: 名称
```
5、删除镜像
```
DELETE /images/(name)
name: 镜像名称
```
6、tag镜像
```
POST /images/(name)/tag

name: 原镜像名称
repo :新镜像名称
tag : 标签
```
7、查看某个镜像
```
GET /images/(name)/json
name: 镜像名称
```
### 容器相关的API
1、容器列表 获取所有容器的清单：
```
GET /containers/json
```
2、查看某个容器
```
GET /containers/{id}/json
id:容器id
```
3、列出运行容器的进程
```
GET /containers/{id}/top
id:容器id
```
4、停止容器
```
POST /containers/(id)/stop
id:容器id
```
5、启动容器
```
POST containers/(id)/start
id:容器id
```
6、重启容器
```
POST /containers/(id)/restart
id:容器id
```
7、重命名容器
```
POST containers/(id)/rename
id:容器id
name:新名称
```
8、删除停止的容器
```
DELETE /containers/{id}
id:容器id
```
9、kill容器
```
POST /containers/{id}/kill
id:容器id
```

### 网络相关的API

1、查询所有网络列表
```
 GET /networks
```
2、查看某个网络
```
 GET /networks/{id}
```
3、移除网络
```
DELETE /networks/{id}
```
4、创建网络
```
POST /networks/create
Name:网络名称
Driver:网络模式 默认：bridge
```
5、关联一个容器到某个网络
```
POST /networks/{id}/connect
 id 网络id
 Container 容器id
```
6、容器断开某个网络
```
POST /networks/{id}/connect
 id 网络id
 Container 容器id
```
参考[docker Api](https://docs.docker.com/engine/api/v1.35/#)
