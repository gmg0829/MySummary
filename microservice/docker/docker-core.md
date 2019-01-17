# Docker核心技术
Docker本质上是宿主机上的进程，Docker通过namespace实现资源隔离，通过cgroups实现资源限制，通过写时复制(copy-on-write)实现高效的文件操作。

Docker底层依赖的核心技术主要包括Linux操作系统的命名空间（Namespaces）,控制组（Control Groups）,联合文件系统（Union File Systems）和Linux虚拟网络支持。

- 命名空间：每个容器都可以拥有自己单独的命名空间，运行在其中的应用都像是在独立的操作系统运行一样。命名空间保证了容器之间彼此互不影响。
- 控制组：主要用来对共享资源进行隔离、限制、审计等。只有能控制分配到容器的资源，Docker才能避免多个容器同时运行时的系统资源竞争。
- 联合文件系统：是一种轻量级的高性能分层文件系统，它支持文件系统中的修改信息作为一次提交，并层层叠加。
## Docker 架构图
![](https://github.com/gmg0829/Img/blob/master/dockerImg/docker-architecture.jpg?raw=true)
docker是一个C/S模式的架构，后端是一个松耦合架构，模块各司其职。

- 用户是使用Docker Client与Docker Daemon建立通信，并发送请求给后者。
- Docker Daemon作为Docker架构中的主体部分，首先提供Server的功能使其可以接受Docker Client的请求；
- Engine执行Docker内部的一系列工作，每一项工作都是以一个Job的形式的存在。
- Job的运行过程中，当需要容器镜像时，则从Docker Registry中下载镜像，并通过镜像管理驱动graphdriver将下载镜像以Graph的形式存储；
- 当需要为Docker创建网络环境时，通过网络管理驱动networkdriver创建并配置Docker容器网络环境；
- 当需要限制Docker容器运行资源或执行用户指令等操作时，则通过execdriver来完成。
- libcontainer是一项独立的容器管理包，networkdriver以及execdriver都是通过libcontainer来实现具体对容器进行的操作。

## Docker各模块组件分析
### 1、Docker Client【发起请求】
- Docker Client是和Docker Daemon建立通信的客户端。用户使用的可执行文件为docker（类似可执行脚本的命令），docker命令后接参数的形式来实现一个完整的请求命令（例如docker images，docker为命令不可变，images为参数可变）。

- Docker Client可以通过以下三种方式和Docker Daemon建立通信：tcp://host:port，unix://path_to_socket和fd://socketfd。

- Docker Client发送容器管理请求后，由Docker Daemon接受并处理请求，当Docker Client接收到返回的请求相应并简单处理后，Docker Client一次完整的生命周期就结束了。[一次完整的请求：发送请求→处理请求→返回结果]，与传统的C/S架构请求流程并无不同。

### 2、Docker Daemon【后台守护进程】

Docker Server相当于C/S架构的服务端。功能为接受并调度分发Docker Client发送的请求。接受请求后，Server通过路由与分发调度，找到相应的Handler来执行请求。

### 3、Docker Registry【镜像注册中心】
Docker Registry是一个存储容器镜像的仓库（注册中心），可理解为云端镜像仓库，按repository来分类，docker pull 按照[repository]:[tag]来精确定义一个image。

在Docker的运行过程中，Docker Daemon会与Docker Registry通信，并实现搜索镜像、下载镜像、上传镜像三个功能，这三个功能对应的job名称分别为"search"，"pull" 与 "push"。

可分为公有仓库（docker hub）和私有仓库。

### 4、Graph【docker内部数据库】

- 已下载容器镜像之间关系的记录者。
- GraphDB是一个构建在SQLite之上的小型图数据库，实现了节点的命名以及节点之间关联关系的记录

### 5、Driver【执行部分】
Driver是Docker架构中的驱动模块。通过Driver驱动，Docker可以实现对Docker容器执行环境的定制。即Graph负责镜像的存储，Driver负责容器的执行。

5.1 graphdriver

- graphdriver主要用于完成容器镜像的管理，包括存储与获取。
- 存储：docker pull下载的镜像由graphdriver存储到本地的指定目录（Graph中）。
- 获取：docker run（create）用镜像来创建容器的时候由graphdriver到本地Graph中获取镜像。

5.2 networkdriver

networkdriver的用途是完成Docker容器网络环境的配置，其中包括

- Docker启动时为Docker环境创建网桥；
- Docker容器创建时为其创建专属虚拟网卡设备；
- Docker容器分配IP、端口并与宿主机做端口映射，设置容器防火墙策略等。

5.3 execdriver

- execdriver作为Docker容器的执行驱动，负责创建容器运行命名空间，负责容器资源使用的统计与限制，负责容器内部进程的真正运行等。
- 现在execdriver默认使用native驱动，不依赖于LXC。

### 6、libcontainer【函数库】

- libcontainer是Docker架构中一个使用Go语言设计实现的库，设计初衷是希望该库可以不依靠任何依赖，直接访问内核中与容器相关的API。

- Docker可以直接调用libcontainer，而最终操纵容器的namespace、cgroups、apparmor、网络设备以及防火墙规则等。

- libcontainer提供了一整套标准的接口来满足上层对容器管理的需求。或者说，libcontainer屏蔽了Docker上层对容器的直接管理。


### 7、docker container【服务交付的最终形式】

- Docker container（Docker容器）是Docker架构中服务交付的最终体现形式。
- Docker按照用户的需求与指令，订制相应的Docker容器：

        1、用户通过指定容器镜像，使得Docker容器可以自定义rootfs等文件系统；
        
        2、用户通过指定计算资源的配额，使得Docker容器使用指定的计算资源；

        3、用户通过配置网络及其安全策略，使得Docker容器拥有独立且安全的网络环境；

        4、用户通过指定运行的命令，使得Docker容器执行指定的工作。

参考  https://www.huweihuang.com/article/docker/docker-architecture/


### Docker如何工作？

#### Docker Image工作方式

Docker Image是只读模板，并随容器一起启动。Docker Image使用的是联合文件系统来将这些层组合成一个镜像。Docker为什么轻量，就是因为使用了这些层状的文件系统。当用户修改一个Docker Image时(如更新应用程序)一个新的层就会被建立。因此，这是一个增量时的修改，而不是一个全新的镜像，因此发布一个镜像时，只需发布差异的部分，速度就非常快。

### 容器工作方式

一个容器由操作系统、用户文件和元数据构成。
```
docker run  ngnix 
```
这个指令内部流程：
- 拉取ngnix镜像：Docker检查本地是否有ngnix镜像，如果不存在就自动从Docker Hub拉取，如果存在进入下一步
- 创建一个容器
- 分配文件系统并挂载一个RW层：容器是创建在文件系统中的，并且在其上增加了一层读写层。由此容器并不会改变原始的镜像。
- 分配网络、桥接模式：创建一个桥接网络接口，使容器可以和本地运行通信。
- 设置一个IP地址：选取一个可用的IP挂载到容器之上。

联合文件系统图：

![](https://github.com/gmg0829/Img/blob/master/dockerImg/union-arc.png?raw=true)