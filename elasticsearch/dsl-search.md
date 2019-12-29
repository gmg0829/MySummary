## matchQuery 和 termQuery
matchQuery：会将搜索词分词，再与目标查询字段进行匹配，若分词中的任意一个词与目标字段匹配上，则可查询到。

termQuery：不会对搜索词进行分词处理，而是作为一个整体与目标字段进行匹配，若完全匹配，则可查询到。

## dsl语句

GET /_search
{
  "query":{
    "match_all": {}
  }
}


GET /ops-coffee/_search
{
  "size": 5,
  "from": 10,
  "query":{
    "match_all": {}
  }
}


GET /ops-coffee/_search
{
  "query":{
    "match": {
      "host":"ops-coffee.cn"
    }
  }
}

GET /product_index/_search
{
  "query": {
    "match": {
      "product_name": "toothbrush"
    }
  },
  "sort": [
    {
      "price": "desc"
    }
  ]
}

GET /product_index/_search
{
  "query": {
    "match_all": {}
  },
  "_source": [
    "product_name",
    "price"
  ]
}

GET /ems/_search
{
  "query": {
    "prefix": {
      "content": {
        "value": "redis"
      }
    }
  }
}

GET /ems/_search
{
  "query": {
    "wildcard": {
      "content": {
        "value": "re*"
      }
    }
  }
}

GET /ems/_search
{
  "query": {
    "fuzzy": {
      "content":"spring"
    }
  }
}





GET /ops-coffee-2019.05.15/_search
{
  "query":{
    "multi_match": {
      "query":"ops-coffee.cn",
      "fields":["host","http_referer"]
    }
  }
}

GET /ops-coffee-2019.05.15/_search
{
  "query":{
    "query_string": {
      "query":"(a.ops-coffee.cn) OR (b.ops-coffee.cn)",
      "fields":["host"]
    }
  }
}

GET /ops-coffee-2019.05.14/_search
{
  "query":{
    "query_string": {
      "query":"host:a.ops-coffee.cn OR (host:b.ops-coffee.cn AND status:403)"
    }
  }
}

GET /ops-coffee-2019.05.14/_search
{
  "query": {
    "terms": {
      "status":[403,404]
    }
  }
}


GET /ops-coffee-2019.05.14/_search
{
  "query": {
    "range":{
      "status":{
        "gte": 400,
        "lte": 599
      }
    }
  }
}


GET /ops-coffee-2019.05.14/_search
{
 "query":{
    "bool": {
      "filter": [
        {"match": {
          "host": "ops-coffee.cn"
        }},
        {"match": {
          "http_x_forwarded_for": "111.18.78.128"
        }}
      ],
      "must_not": {
        "match": {
          "status": 200
        }
      }
    }
  }
}










