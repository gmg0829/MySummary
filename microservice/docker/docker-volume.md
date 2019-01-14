# 数据管理
容器中管理数据的两种方式：
- 数据卷 将主机的卷mount进入容器
- 数据卷容器 将外部容器分享给容器

### 数据卷
    数据卷是一个可供容器使用的特殊目录，可以提供很多有用的特性：
    - 数据卷可以在容器之间共享和重用
    - 对数据卷的修改会立马生效
    - 对数据卷的更新，不会影响镜像
    - 卷会一直存在，直到没有容器使用

    #### 创建数据卷
    ```
    docker run -d -P --name nginxTest -v /nginxData nginx
    ```
    查看数据卷nginxData在主机的位置
    ```
    docker inspect id

    "Mounts": [
                {
                    "Type": "volume",
                    "Name": "edbf8e4743717f9e6a63f046781f40aa8fbdbd025d7580802264c8ec24513cbd",
                    "Source": "/var/lib/docker/volumes/edbf8e4743717f9e6a63f046781f40aa8fbdbd025d7580802264c8ec24513cbd/_data",
                    "Destination": "/nginxData",
                    "Driver": "local",
                    "Mode": "",
                    "RW": true,
                    "Propagation": ""
                }
            ]
    ```
    它的位置在 (/var/lib/docker/volumes)

    #### 映射一个外部卷
    ```
    docker run -d -it  -v /nginxDataLocal:/nginxData1 nginx
    ```
    上面命令加载主机的/nginxDataLocal到容器的/nginxData1,这个功能在进行测试的时候十分方便，用户可以纺织一些程序或数据到本地目录下，然后在容器内运行和使用。

### 数据卷容器
    如果用户需要在容器之内共享一些持续更新的数据，最简单的方式是使用数据卷容器，数据卷其实就是一个普通的容器。

    第一步 创建一个包含外部卷的容器
    ```
    docker run -v /nginxData2 --name nginxData nginx
    ```
    第二步 在另一个容器中通过--volumes-from来映射
    ```
    docker run -d -it --volumes-from nginxData --name nginxDataF nginx
    ```
    测试：
    在nginxData容器中创建一个test文件
    ```
    cd /nginxData2
    touch test.txt
    ```
    在nginxDataF容器查看
    ```
    $ docker exec -it 9a29c76cb145 bash
    $ cd nginxData2/
    $ ls
    test.txt

    ```
    注意：数据卷的容器自身并不需要保持在运行状态

    如果删除了挂载的容器，数据卷不会自动删除，如果想要删除一个数据卷，必须在删除最后一个挂载着它的容器时显式删除docker rm -v 命令删除。

