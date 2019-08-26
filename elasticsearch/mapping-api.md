# mapping

类似于数据库中的表结构定义，主要作用如下：

- 定义Index下字段名（Field Name）
- 定义字段的类型，比如数值型，字符串型、布尔型等
- 定义倒排索引的相关配置，比如是否索引、记录postion等

需要注意的是，在索引中定义太多字段可能会导致索引膨胀，出现内存不足和难以恢复的情况，下面有几个设置：

- index.mapping.total_fields.limit：一个索引中能定义的字段的最大数量，默认是 1000
- index.mapping.depth.limit：字段的最大深度，以内部对象的数量来计算，默认是20
- index.mapping.nested_fields.limit：索引中嵌套字段的最大数量，默认是50

## 核心数据类型
- 字符串
  - text 用于全文索引，该类型的字段将通过分词器进行分词，最终用于构建索引
  - keyword  不分词，只能搜索该字段的完整的值，只用于 filtering
- 数值型 
  - long：有符号64-bit integer：-2^63 ~ 2^63 - 1
  - integer：有符号32-bit integer，-2^31 ~ 2^31 - 1
  - short：有符号16-bit integer，-32768 ~ 32767
  - byte： 有符号8-bit integer，-128 ~ 127
  - double：64-bit IEEE 754 浮点数
  - float：32-bit IEEE 754 浮点数
  - half_float：16-bit IEEE 754 浮点数
  - scaled_float
- 布尔 - boolean
   - 值：false, "false", true, "true"  
- 时间  
   - date   
- 范围类型
   - 范围类型表示值是一个范围，而不是一个具体的值
   - 譬如 age 的类型是 integer_range，那么值可以是  {"gte" : 10, "lte" : 20}；搜索 "term" : {"age": 15} 可以搜索该值；搜索 "range": {"age": {"gte":11, "lte": 15}} 也可以搜索到
   - integer_range, float_range, long_range, double_range, date_range
## 复杂数据类型
- 数组
  - 字符串数组 [ "one", "two" ]
  - 整数数组 [ 1, 2 ]
  - 数组的数组  [ 1, [ 2, 3 ]]，相当于 [ 1, 2, 3 ]
  - Object对象数组 [ { "name": "Mary", "age": 12 }, { "name": "John", "age": 10 }]
  - 同一个数组只能存同类型的数据，不能混存，譬如 [ 10, "some string" ] 是错误的
  - 数组中的 null 值将被 null_value 属性设置的值代替或者被忽略
  - 空数组 [] 被当做 missing field 处理
- 对象
  - 对象类型可能有内部对象
  - 被索引的形式为：manager.name.first    
 ```
 PUT my_index
{
  "mappings": {
    "_doc": {
      "properties": {
        "user": {
          "type": "nested" 
        }
      }
    }
  }
}

PUT my_index/_doc/1
{
  "group": "fans",
  "user": [
    {
      "first": "John",
      "last": "Smith"
    },
    {
      "first": "Alice",
      "last": "White"
    }
  ]
}
 ```  
##  地理位置数据类型
- geo_point
 地理位置，其值可以有如下四中表现形式：
 - object对象："location": {"lat": 41.12, "lon": -71.34}
 - 字符串："location": "41.12,-71.34"
 - geohash："location": "drm3btev3e86"
 - 数组："location": [ -71.34, 41.12 ]
查询的时候通过 Geo Bounding Box Query  进行查询
- geo_shape
## 专用数据类型
- 记录IP地址 ip
- 实现自动补全 completion
- 记录分词数 token_count
- 记录字符串hash值 murmur3
- Percolator
```
PUT my_index
{
  "mappings": {
    "_doc": {
      "properties": {
        "ip_addr": {
          "type": "ip"
        }
      }
    }
  }
}
```
## Mapping参数

- analyzer
   分词器，默认为standard analyzer，当该字段被索引和搜索时对字段进行分词处理
- boost
  字段权重，默认为1.0   
- dynamic
Mapping中的字段类型一旦设定后，禁止直接修改，原因是：Lucene实现的倒排索引生成后不允许修改
只能新建一个索引，然后reindex数据
默认允许新增字段
通过dynamic参数来控制字段的新增：
  - true（默认）允许自动新增字段
  - false 不允许自动新增字段，但是文档可以正常写入，但无法对新增字段进行查询等操作
  - strict 文档不能写入，报错 
  ```
  PUT my_index
  {
    "mappings": {
      "_doc": {
        "dynamic": false, 
        "properties": {
          "user": { 
            "properties": {
              "name": {
                "type": "text"
              },
              "social_networks": { 
                "dynamic": true,
                "properties": {}
              }
            }
          }
        }
      }
    }
  }

  ```  
- copy_to
  - 将该字段复制到目标字段，实现类似_all的作用
  - 不会出现在_source中，只用来搜索
  ```
  PUT my_index
  {
    "mappings": {
      "doc": {
        "properties": {
          "first_name": {
            "type": "text",
            "copy_to": "full_name" 
          },
          "last_name": {
            "type": "text",
            "copy_to": "full_name" 
          },
          "full_name": {
            "type": "text"
          }
        }
      }
    }
  }

  PUT my_index/doc/1
  {
    "first_name": "John",
    "last_name": "Smith"
  }

  GET my_index/_search
  {
    "query": {
      "match": {
        "full_name": { 
          "query": "John Smith",
          "operator": "and"
        }
      }
    }
  }
  ```
- index
   控制当前字段是否索引，默认为true，即记录索引，false不记录，即不可搜索  
- index_options
  - index_options参数控制将哪些信息添加到倒排索引，以用于搜索和突出显示，可选的值有：docs，freqs，positions，offsets
  - docs：只索引 doc id
  - freqs：索引 doc id 和词频，平分时可能要用到词频
  - positions：索引 doc id、词频、位置，做 proximity or phrase queries 时可能要用到位置信息
  - offsets：索引doc id、词频、位置、开始偏移和结束偏移，高亮功能需要用到offsets   
## Dynamic Mapping
ES是依靠JSON文档的字段类型来实现自动识别字段类型。

## 新建mapping
```
PUT twitter 
{}

PUT twitter/_mapping 
{
  "properties": {
    "email": {
      "type": "keyword"
    }
  }
}



PUT twitter-1
PUT twitter-2

# Update both mappings
PUT /twitter-1,twitter-2/_mapping 
{
  "properties": {
    "user_name": {
      "type": "text"
    }
  }
}
```

### 更新mapping

```
PUT my_index 
{
  "mappings": {
    "properties": {
      "name": {
        "properties": {
          "first": {
            "type": "text"
          }
        }
      },
      "user_id": {
        "type": "keyword"
      }
    }
  }
}

PUT my_index/_mapping
{
  "properties": {
    "name": {
      "properties": {
        "last": { 
          "type": "text"
        }
      }
    },
    "user_id": {
      "type": "keyword",
      "ignore_above": 100 
    }
  }
}
```

### 获取mapping
```
GET /twitter/_mapping

GET /twitter,kimchy/_mapping

GET /_all/_mapping

GET /_mapping

```
### 获取mapping的属性
```
PUT publications
{
    "mappings": {
        "properties": {
            "id": { "type": "text" },
            "title":  { "type": "text"},
            "abstract": { "type": "text"},
            "author": {
                "properties": {
                    "id": { "type": "text" },
                    "name": { "type": "text" }
                }
            }
        }
    }
}

GET publications/_mapping/field/title
GET publications/_mapping/field/a*
GET publications/_mapping/field/author.id,abstract,name
GET /twitter,kimchy/_mapping/field/message
GET /_all/_mapping/field/message,user.id
GET /_all/_mapping/field/*.id
```

### 参考
https://juejin.im/post/5b799dcb6fb9a019be279bd7#heading-10

https://www.elastic.co/guide/en/elasticsearch/reference/7.3/mapping.html


