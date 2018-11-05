## 1、下载docker官方仓库的jenkins镜像

```
docker pull jenkins/jenkins
```
## 2、创建本地映射目录并启动：
```
创建目录并授权
mkidr -p /jenkins_home && chmod -R 777 /jenkins_home
启动容器
docker run -it -d --restart always --name jenkins -p 8080:8080 -p 50000:50000 -v /jenkins_home:/var/jenkins_home jenkins/jenkins 
```
## 3、在浏览器中访问jenkins
访问地址http://ip地址:8080,密码在/jenkins_home/secrets/initialAdminPassword 
