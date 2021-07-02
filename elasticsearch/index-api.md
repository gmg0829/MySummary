## 索引api

### 新建索引

```
PUT test
{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "properties" : {
            "field1" : { "type" : "text" }
        }
    }
}

PUT twitter
{
    "settings" : {
        "index" : {
            "number_of_shards" : 3, 
            "number_of_replicas" : 2 
        }
    }
}
```

### 删除索引
```
DELETE test
```

### 获取索引

```
GET test
```

### 更新索引_settings

```
PUT /twitter/_settings
{
    "index" : {
        "number_of_replicas" : 2
    }
}
```
### 获取索引_settings

```
GET /twitter/_settings
```

#查看索引的文档总数
GET kibana_sample_data_ecommerce/_count

#查看前10条文档，了解文档格式
POST kibana_sample_data_ecommerce/_search
{
}

#_cat indices API
#查看indices
GET /_cat/indices/kibana*?v&s=index

#查看状态为绿的索引
GET /_cat/indices?v&health=green

#按照文档个数排序
GET /_cat/indices?v&s=docs.count:desc

#查看具体的字段
GET /_cat/indices/kibana*?pri&v&h=health,index,pri,rep,docs.count,mt

#How much memory is used per index?
GET /_cat/indices?v&h=i,tm&s=tm:desc
```


http://www.shixinke.com/elasticsearch/index-settings-parameters


参考 
https://www.elastic.co/guide/en/elasticsearch/reference/7.1/indices-create-index.html