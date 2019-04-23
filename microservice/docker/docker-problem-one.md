# 问题1  修改docker容器默认空间大小

docker 启动一个容器后默认根分区大小为10GB，通过docker info可以看见默认大小为10G,有时会不够用需要扩展。

## 1、首先先进入目录（使用yum安装docker的默认目录）：
```
cd /dev/mapper/
```
## 2、使用命令查看容器是否正在运行。
```
docker ps -a
```
## 3、使用命令查看容器卷：
```
dmsetup table
```
找到自己要修改的 卷空间值

## 4、查看在/dev/mapper/目录下的文件是否存在。

## 5、使用命令修改容器空间大小：
```
echo 0 88080384 thin 253:7 11 | dmsetup load docker-253:1-184549824-95f242e4fe2fef132ab1a706ebf8eecbb1c6db19547c3f12b34b76a5dee96c7e
```
接着使用命令：
```
dmsetup resume docker-253:1-184549824-95f242e4fe2fef132ab1a706ebf8eecbb1c6db19547c3f12b34b76a5dee96c7e

xfs_growfs  /dev/mapper/docker-253:1-184549824-95f242e4fe2fef132ab1a706ebf8eecbb1c6db19547c3f12b34b76a5dee96c7e
```
## 6、

完成。

然后进入容器的终端，使用命令df -h即可看到修改后的容器空间：



参考  https://www.cnblogs.com/HD/p/4807088.html