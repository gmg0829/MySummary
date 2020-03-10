## 分布式文档存储
路由文档到分片
shard = hash(routing) % number_of_primary_shards
routing 值是一个任意字符串，它默认是 _id 但也可以自定义。
## 新建、索引和删除文档
1. 客户端给 Node 1 发送新建、索引或删除请求。
2. 节点使用文档的 _id 确定文档属于分片 0 。它转发请求到 Node 3 ，分片 0 位于这个节
点上。
3. Node 3 在主分片上执行请求，如果成功，它转发请求到相应的位于 Node 1 和 Node 2 的
复制节点上。当所有的复制节点报告成功， Node 3 报告成功到请求的节点，请求的节点
再报告给客户端。

复制默认的值是 sync 。这将导致主分片得到复制分片的成功响应后才返回。

## 检索文档
文档能够从主分片或任意一个复制分片被检索。

1. 客户端给 Node 1 发送get请求。
2. 节点使用文档的 _id 确定文档属于分片 0 。分片 0 对应的复制分片在三个节点上都
有。此时，它转发请求到 Node 2 。
3. Node 2 返回文档(document)给 Node 1 然后返回给客户端。


## 查询并更新某个字段
POST /megacorp/_update_by_query
{
  "script": {
    "source": "ctx._source.age=100",
    "lang": "painless"
  },
  "query": {
        "match" : {
            "first_name" : "GMG"
        }
    }
}
## 查询并删除
POST /megacorp/_delete_by_query
{
  "query": {
    "match": {
      "first_name": "GMG"
    }
}
}

GET /megacorp/_search
GET /megacorp/_search?size=2
GET /megacorp/_search?size=5&from=5
GET /megacorp/_search?q=age:32
GET /megacorp/_search?q=+first_name:Jane +last_name:Smith
GET /megacorp/_mapping/employee

## 相关性简介
ElasticSearch的相似度算法被定义为 TF/IDF，即检索词频率/反向文档频率。
检索词频率:检索词 `honeymoon` 在 `tweet` 字段中的出现次数。
反向文档频率:检索词 `honeymoon` 在 `tweet` 字段在当前文档出现次数与索引中其他文档的出现总数的比率。

GET /megacorp/employee/1/_explain
{
      "query" : {
        "match" : { "last_name" : "Smith" }
      }
}

## 扫描和滚屏
scan（扫描） 搜索类型是和 scroll（滚屏） API一起使用来从Elasticsearch里高效地取回巨大数
量的结果而不需要付出深分页的代价。

GET /megacorp/_search?scroll=1m
{
"query": { "match_all": {}},
"size": 2
}

### 游标查询过期时间为一分钟
GET /_search/scroll
{
    "scroll": "1m",
    "scroll_id" : "DnF1ZXJ5VGhlbkZldGNoBQAAAAAAANZ6FldRMGtOWmtxVHJlWVFyNGsyN1BZaUEAAAAAAADWeBZXUTBrTlprcVRyZVlRcjRrMjdQWWlBAAAAAAAA1nsWV1Ewa05aa3FUcmVZUXI0azI3UFlpQQAAAAAAANZ5FldRMGtOWmtxVHJlWVFyNGsyN1BZaUEAAAAAAADWfBZXUTBrTlprcVRyZVlRcjRrMjdQWWlB"
}

### _source

GET /megacorp/_search
{
"query": { "match_all": {}},
"_source": [ "first_name", "last_name" ]
}

