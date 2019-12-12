## Dockerfile制作镜像

### 编写文件
- Dockerfile 构建镜像的文件
- init_database.sql 创建库和表的sql

### 生成镜像
docker build -t elensdatamariadb:v1 .

### 查看本地镜像
```
docker images
```

### 根据镜像生成容器

```
docker run -d --name mariadb -e MYSQL_ROOT_PASSWORD=root -p 5306:3306 -v /data/mariadbdata/mariadb:/var/lib/mysql elensdatamariadb:v1
```


