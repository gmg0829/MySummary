## 容器监控
快速构建容器监控系统cAdvisor+InfluxDB+Grafana

- cAdvisor：负责收集容器的随时间变化的数据

- influxdb：负责存储时序数据

- grafana：负责分析和展示时序数据

### 部署Influxdb服务
```
docker run -d --name influxdb -p 8083:8083 -p 8086:8086 tutum/influxdb
```
参数说明：
```
-d ：后台运行此容器；
--name ：启运容器分配名字influxdb；
-p ：映射端口，8083端口为infuxdb后台控制端口，8086端口是infuxdb的数据端口；
tutum/influxdb：通过这个容器来运行的，默认会在docker官方仓库pull下来；
```
访问8083，创建cadvisor的数据库与用户，这个用于后期配置granfa

### 部署cAdvisor服务
```
docker run -d \
-p 8082:8080 \
-v /:/rootfs -v /var/run:/var/run -v /sys:/sys \
-v /var/lib/docker:/var/lib/docker \
--link=influxdb:influxdb --name cadvisor google/cadvisor \
--storage_driver=influxdb \
--storage_driver_host=influxdb:8086 \
--storage_driver_db=cadvisor \
--storage_driver_user=admin \
--storage_driver_password=admin
```
参数说明：
```
d ：后台运行此容器；
--name ：启运容器分配名字cadvisor；
-p ：映射端口8082；
-storage_driver：需要指定cadvisor的存储驱动、数据库主机、数据库名；
google/cadvisor：通过cadvisor这个镜像来运行容器，默认会在docker官方仓库把镜像pull下来；
```
### 部署Grafana服务
```
docker run -d --name grafana -p 3000:3000 \
--link=influxdb:influxdb \
 grafana/grafana
```

### 实战

访问Grafana，通过ip+3000端口的方式访问,默认账户密码（admin/admin）。

第一步：添加数据源

![](https://github.com/gmg0829/Img/blob/master/dockerImg/gra-datadource.png?raw=true)

第二步：添加面板

![](https://github.com/gmg0829/Img/blob/master/dockerImg/add-panel.png?raw=true)


![](https://github.com/gmg0829/Img/blob/master/dockerImg/enter-panel.png?raw=true)

第三步：增加查询条件

![](https://github.com/gmg0829/Img/blob/master/dockerImg/add-query.png?raw=true)


![](https://github.com/gmg0829/Img/blob/master/dockerImg/success-panel.png?raw=true)


第四步:查看你监控数据

![](https://github.com/gmg0829/Img/blob/master/dockerImg/show-panel.png?raw=true)

