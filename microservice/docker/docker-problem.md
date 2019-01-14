Docker 版本17.12.1-ce

## docker 网络
Docker的网络实现其实利用了Linux的网络命名空间和虚拟网络设备（特别是veth pair）。
它在本地主机和容器内分别创建一个虚拟接口，并让它们彼此连通（这样一对接口叫做veth pair）。

### 网络创建过程

    Docker创建一个容器的时候，会执行如下操作

    - 创建一对虚拟接口，分别放在本地和新容器的命名空间中。
    - 本地主机一端的虚拟接口连接到默认的docker0网桥，并以veth开头的唯一名字。
    - 容器一端的虚拟接口将放在新创建的容器中，并修改名字为eth0。
    - 从网桥可用地址中获取一个空闲地址分配给容器的eth0,并配置默认路由网关为docker0网卡的内部接口docker0的ip地址。

### 容器自带的网络：
```
docker network ls 
NETWORK ID          NAME                DRIVER              SCOPE
ec2989c51fef        bridge              bridge              local
7db9051f6518        host                host                local
1b6cb3a83fb5        none                null                local
```
网络|描述|
---|:--:
none|容器不能访问外部网络
host|使用和主机相同的网络
bridge(默认)|容器通过veth连接到主机的桥接上
1、none

容器不能访问外部网络.

2、bridge

桥接是在主机上的,通常为docker0。Docker启动时会在主机上自动创建一个Docker0虚拟网桥，Docker随机分配一个本地未占用的私有网段中的一个地址给docker0接口，例如典型的172.17.42.1，掩码255.255.0.0。此后启动的容器内的网口会自动分配一个同一网段(172.17.0.0/16)地址。

当创建一个容器时，同时会创建一对veth pair接口(当数据包发送到一个接口时，另外一个接口也可以收到相同的数据包)。这对接口一端在容器内，即eth0;另一端在本地并挂载到docker0网桥,名称以veth开头。通过这种方式,主机可以跟容器通信，容器之间也可以相互通信。Docker就在主机和所有容器之间创建了一个虚拟共享网络。


![](https://github.com/gmg0829/Img/blob/master/dockerImg/docker-network.png?raw=true)
3、host

host 网络在主机网络堆栈上添加一个容器。您可以发现，容器中的网络配置与主机相同。相比于桥接，该模式由于没有通过iptable的转发,性能上要比桥接好一些。在对网络性能特别关注时，如HAProxy等负载均衡器时，可以使用host模式



对于bridge而言，默认是主机挂载在主机的docker0上的。
在主机上通过ifconfig可以查看到：
```
$ ifconfig
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:e7:af:5f:93  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```
通过docker network inspect bridge查看本机Docker网络的信息。
```
docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "ec2989c51fef4e8218487900cc2e8eb7f3657c684f3ad5c342ca3c83a8ed31ec",
        "Created": "2018-11-26T04:21:17.414945018-05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]

```
运行ngnix容器
```
$ docker run -d -p 80:80 nginx:latest
```
查看Docker网络信息：
```
$ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "ec2989c51fef4e8218487900cc2e8eb7f3657c684f3ad5c342ca3c83a8ed31ec",
        "Created": "2018-11-26T04:21:17.414945018-05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "207f0308a472a1997e19eaf9966de765a3bcff5197735e810687dcb8cf9ed7d0": {
                "Name": "serene_kowalevski",
                "EndpointID": "3cc7178db0366e5f86dfcc6d4a3cd58647a14498092954f28382cd7bf3028d04",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```
当启动一个容器时，在上面Containers下面加入相关的网络信息。

### 用户自定义网络
除默认的网络外，Docker还允许用户创建自己的网络。主要包括三种:桥接；Overlay网络;插件网络。

#### 桥接网络
系统默认的桥接是docker0,将多个容器隔离在一个新的桥接网络中。可以使用如下命令：
```
$ docker network create --driver bridge mynet
1a32fd6bb26a64d37c42f7238130b10cab0a184bb10715c942878b5fe666d0db

$ docker network inspect mynet
[
    {
        "Name": "mynet",
        "Id": "1a32fd6bb26a64d37c42f7238130b10cab0a184bb10715c942878b5fe666d0db",
        "Created": "2018-11-26T21:54:24.071258917-05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]

```
通过--net属性将容器挂接到mynet中。
```
$ docker run --net=mynet -it nginx

$ docker network inspect mynet
[
    {
        "Name": "mynet",
        "Id": "1a32fd6bb26a64d37c42f7238130b10cab0a184bb10715c942878b5fe666d0db",
        "Created": "2018-11-26T21:54:24.071258917-05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "33eb0b4b7e6c5bc7c2ce8088ac5b4ce3d43d47543212937201e5dd3ca02607c2": {
                "Name": "hungry_goldstine",
                "EndpointID": "316b2d65124f28661b5562b397c2ae63df0802bf8ecbd8435159b8ee95b474b3",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

```
在同一个桥接下,形成了一个私网，相互之间是可以访问的,但是仅限于在同一台主机上。若跨机通信,就必须使用Overlay网络。

#### Overlay网络
 Overlay是一种虚拟交换技术,主要解决不同IP地址段之间的网络通信问题。Docke使用的Overlay技术是VXLAN,是借助于libnetwork实现的。Overlay需要一个K-V服务来存储相关的主机信息。目前Docker支持的K-V存储服务有Consul、Etcd和ZooKeeper。

 overlay网络模式如下：
![](https://github.com/gmg0829/Img/blob/master/dockerImg/overlay.png?raw=true)

 

Docker目前提供了映射容器端口到宿主机和容器互联机制为容器提供网络服务。

#### 端口映射访问容器应用
在启动容器的时候,如果不指定对应参数,在容器外部是无法通过网络来访问容器内的网络应用和服务的。

当容器中运行一些网络应用,要让外部访问时，可以通过-P或-p参数来指定端口映射。

#### 容器互联实现容器间通信
容器的连接，它会在源和接受容器之间创建一个隧道，接受容器能看到源容器指定的信息。连接系统依据容器的名称来执行。

创建一个web容器并连接到db容器。
```
$ docker run -d --name db  training/mysql
$ docker run -d -P --name web --link db:db training/webapp
```
Docker通过两种方式为容器公开连接信息:
- 环境变量
- 更新/etc/hosts文件
使用env命令查看web容器的环境变量
```
$ docker run --rm --name web2 --link db:db training/webapp env
...
DB_NAME=web2/db
DB_PORT=tcp://172.17.0.5:5432
DB_PORT_5000_TCP=tcp://172.17.0.5:5432
DB_PORT_5000_TCP_PROTO=tcp
DB_PORT_5000_TCP_PORT=5432
DB_PORT_5000_TCP_ADDR=172.17.0.5
```
其中DB_开头的环境变量是提供web容器连接到db容器使用,前缀采用大写的连接别名。

除了环境变量,Docker还添加host信息到父容器的/etc/hosts的文件。下面是父容器web的hosts文件:
```
$ cat /etc/hosts
172.17.0.7 aed84ee21bde
.
.
172.17.0.7 db
```
这两个有hosts信息,第一个是web容器,web容器使用自己的id做为默认主机名,
第二个是db的ip和容器名。


### 网络相关参数
 docker run执行时执行
 - -h HOSTNAME 配置容器主机名
 - -link 添加到另一个容器的连接
 - -net bridge|none 配置容器桥接模式
 - -p 映射容器端口到宿主主机

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

# docker零配置迁移

# k8s api
# k8s和docker关系
