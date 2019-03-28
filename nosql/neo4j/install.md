## 安装

## 常规安装


## docker安装

### 端口简介

7474,7473端口用于管理界面，7687端口用于登录连接neo4j服务端。
- 7474 for HTTP
- 7473 for HTTPS
- 7687 for Bolt

```
docker run \
    --name testneo4j \
    -p7474:7474 -p7687:7687 \
    -d \
    -v $HOME/neo4j/data:/data \
    -v $HOME/neo4j/logs:/logs \
    -v $HOME/neo4j/import:/var/lib/neo4j/import \
    -v $HOME/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/test \
    neo4j:latest
```

### Neo4j Browser
访问 localhost:7474

### Cypher Shell
```
# 进入容器
docker exec -it testneo4j bash
# 进入shell
cypher-shell -u neo4j -p test
# 退出
:exit
```


