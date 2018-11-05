# 安装gitlab

## 1、获取 GitLab 镜像
```
docker pull gitlab/gitlab-ce:latest
```
查看本地镜像
```
docker images
REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
gitlab/gitlab-ce                        latest              73232070607a        5 days ago          1.56GB
```
## 2、创建目录并运行容器
```
mkdir -p /data/gitlab/{config,data,logs}

docker run --detach \
       --hostname localhost \
       --publish 1443:443 \
       --publish 8888:80 \
       --publish 122:22 \
       --name gitlab \
       --restart always \
       --volume /data/gitlab/config:/etc/gitlab \
       --volume /data/gitlab/logs:/var/log/gitlab \
       --volume /data/gitlab/data:/var/opt/gitlab \
       gitlab/gitlab-ce:latest
```
## 3、访问
访问 http://localhost:8888/

初始账户
```
用户: root
密码: 5iveL!fe
```






