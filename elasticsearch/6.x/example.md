## 增加数据
PUT /megacorp/employee/1
{
"first_name" : "John",
"last_name" : "Smith",
"age" : 25,
"about" : "I love to go rock climbing",
"interests": [ "sports", "music" ]
}

PUT /megacorp/employee/2
{
"first_name" : "Jane",
"last_name" : "Smith",
"age" : 32,
"about" : "I like to collect rock albums",
"interests": [ "music" ]
}

PUT /megacorp/employee/3
{
"first_name" : "Douglas",
"last_name" : "Fir",
"age" : 35,
"about": "I like to build cabinets",
"interests": [ "forestry" ]
}

## mapping
GET /megacorp/_mapping
## 检索文档
GET /megacorp/employee/_count
GET /megacorp/employee/1
GET /megacorp/employee/_search
GET /megacorp/employee/_search?q=last_name:Smith

GET /megacorp/employee/_search
{
"query" : {
"match" : {
"last_name" : "Smith"
}
}
}

GET /megacorp/employee/_search
{
"query" : {
"match" : {
"about" : "rock climbing"
}
}
}

GET /megacorp/employee/_search
{
"query" : {
"match_phrase" : {
"about" : "rock climbing"
}
}
}

GET /megacorp/employee/_search
{
    "query" : {
        "bool" : {
            "filter" : {
                "range" : {
                    "age" : {
                        "gt" : 30
                    }
                }
            },
            "must" : {
                "match" : {
                    "last_name" : "Smith"
                }
            }
        }
    }
}


GET /megacorp/employee/_search
{
"query" : {
"match_phrase" : {
"about" : "rock climbing"
}
},
"highlight": {
"fields" : {
"about" : {}
}
}
}

## 分析

### 开启分析
PUT megacorp/_mapping/employee/
{
  "properties": {
    "interests": { 
      "type":     "text",
      "fielddata": true
    }
  }
}

GET /megacorp/employee/_search
{
"aggs": {
"all_interests": {
"terms": { "field": "interests" }
}
}
}

GET /megacorp/employee/_search
{
"query": {
"match": {
"last_name": "smith"
}
},
"aggs": {
"all_interests": {
"terms": {
"field": "interests"
}
}
}
}

GET /megacorp/employee/_search
{
"aggs" : {
"all_interests" : {
"terms" : { "field" : "interests" },
"aggs" : {
"avg_age" : {
"avg" : { "field" : "age" }
}
}
}
}
}

## 集群

GET /_cluster/health

##  索引

DELETE /my-index
DELETE /index_*
DELETE /_all

PUT /my_index
{
"settings": {
"number_of_shards" : 1,
"number_of_replicas" : 0
}
}

PUT /my_index/_settings
{
"number_of_replicas": 1
}

## 分词器
standard
lowercase
stop

POST _analyze
{
  "analyzer": "stop",
  "text": ["The 2 QUICK Brown Foxes jumped over the lazy dog's bone."]
}


POST _analyze
{
  "tokenizer": "standard",
  "filter": ["lowercase"],
  "text": ["Hello World"]
}

### 中文分词

elasticsearch-plugin.bat install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.3.0/elasticsearch-analysis-ik-6.3.0.zip

elasticsearch-plugin.bat install elasticsearch-analysis-ik-6.3.0.zip

POST _analyze
{
  "analyzer": "ik_smart",
  "text": ["公安部：各地校车将享最高路权"]
}

POST _analyze
{
  "analyzer": "ik_max_word",
  "text": ["公安部：各地校车将享最高路权"]
}

### Character Filters

POST _analyze
{
  "tokenizer": "keyword",
  "char_filter": ["html_strip"],
  "text": ["<p>I&apos;m so <b>happy</b>!</p>"]
}

### Tokenizers

standard 按照单词进行分割
letter 按照非字符类进行分割
whitespace 按照空格进行分割
UAX URL Email 按照standard进行分割，但不会分割邮箱和URL
Ngram 和 Edge NGram 连词分割
Path Hierarchy 按照文件路径进行分割

POST _analyze
{
  "tokenizer": "path_hierarchy",
  "text": ["/path/to/file"]
}

### Token Filters

lowercase 将所有term转为小写
stop 删除停用词
Ngram 和 Edge NGram 连词分割
Synonym 添加近义词的term

### 自定义分词

PUT test_index_1
{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_custom_analyzer": {
          "type":      "custom",
          "tokenizer": "standard",
          "char_filter": [
            "html_strip"
          ],
          "filter": [
            "uppercase",
            "asciifolding"
          ]
        }
      }
    }
  }
}

POST test_index_1/_analyze
{
  "analyzer": "my_custom_analyzer",
  "text": ["<p>I&apos;m so <b>happy</b>!</p>"]
}

## bulk

POST /my_store/products/_bulk
{ "index": { "_id": 1 }}
{ "price" : 10, "productID" : "XHDK-A-1293-#fJ3" }
{ "index": { "_id": 2 }}
{ "price" : 20, "productID" : "KDKE-B-9947-#kL5" }
{ "index": { "_id": 3 }}
{ "price" : 30, "productID" : "JODL-X-1937-#pV7" }
{ "index": { "_id": 4 }}
{ "price" : 30, "productID" : "QQPX-R-3956-#aD8" }

DELETE /my_store

PUT /my_store
{
"mappings" : {
"products" : {
"properties" : {
"productID" : {
"type" : "string",
"index" : "not_analyzed"
}
}
}
}
}

## 使用外部版本控制系统

PUT /website/blog/2?version=5&version_type=external
{
"title": "My first external blog entry",
"text": "Starting to get the hang of this..."
}


PUT /website/blog/2?version=10&version_type=external
{
"title": "My first external blog entry",
"text": "This is a piece of cake..."
}


## mget

POST /website/blog/_mget
{
"ids" : [ "2", "1" ]
}

## 更新时的批量操作

create 当文档不存在时创建之。详见《创建文档》
index 创建新文档或替换已有文档。见《索引文档》和《更新文档》
update 局部更新文档。见《局部更新》
delete 删除一个文档。见《删除文档》

POST /_bulk
{ "delete": { "_index": "website", "_type": "blog", "_id": "123" }}
{ "create": { "_index": "website", "_type": "blog", "_id": "123" }}
{ "title": "My first blog post" }
{ "index": { "_index": "website", "_type": "blog" }}
{ "title": "My second blog post" }






















