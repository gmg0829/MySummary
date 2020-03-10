# Es安装

## 7.2.0

elasticsearch

[1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
[2]: max number of threads [3818] for user [elsearch] is too low, increase to at least [4096]
[3]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must


## es 文件目录结构

- bin 脚本文件，启动命令，安装插件， 统计
- config 配置文件

## jvm 配置
默认 1Gb
Xmx Xms 设置成一样
Xmx 不超过总内存的50%
不要超过30gb。https://www.elastic.co/blog/a-heap-of-trouble

## 插件管理

- 安装插件
```
bin/elasticsearch-plugin install analysis-icu
```
- 查看插件
```
bin/elasticsearch-plugin list
```
- 查看安装的插件
```
GET http://localhost:9200/_cat/plugins?v
```
参考
https://www.elastic.co/guide/en/elasticsearch/plugins/current/index.html


## 单节点集群

```
bin/elasticsearch -E node.name=node0 -E cluster.name=geektime -E path.data=node0_data
bin/elasticsearch -E node.name=node1 -E cluster.name=geektime -E path.data=node1_data
bin/elasticsearch -E node.name=node2 -E cluster.name=geektime -E path.data=node2_data
bin/elasticsearch -E node.name=node3 -E cluster.name=geektime -E path.data=node3_data

# 查看集群
GET http://localhost:9200
# 查看nodes
GET _cat/nodes
GET _cluster/health
```
## 启动

elasticsearch -d
kibana.bat

elasticsearch-plugin.bat install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.6.9/elasticsearch-analysis-ik-5.6.9.zip

## 安装坑
https://www.cnblogs.com/zhi-leaf/p/8484337.html
```
docker run -d --name=espn-50 -p 9200:9200 -p 9300:9300  -v /var/espn/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /var/espn/data:/usr/share/elasticsearch/data elasticsearch:5.6.9

docker run -p 9100:9100 mobz/elasticsearch-head:5
```










