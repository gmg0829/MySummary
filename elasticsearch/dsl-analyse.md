## 聚合分析

对一个数据集求最大、最小、和、平均值等指标的聚合，在ES中称为指标聚合   metric

对查询出的数据进行分组group by，再在组上进行指标聚合。在 ES 中group by 称为分桶，桶聚合 bucketing

ES中还提供了矩阵聚合（matrix）、管道聚合（pipleline）。

GET /product_index/_search
{
  "size": 0,
  "query": {
    "match": {
      "product_name": "toothbrush"
    }
  },
  "aggs": {
    "query_product_group_by_tags": {
      "terms": {
        "field": "tags"
      }
    }
  }
}

GET /product_index/_search
{
  "size": 0,
  "query": {
    "match": {
      "product_name": "toothbrush"
    }
  },
  "aggs": {
    "query_product_group_by_tags_and_avg": {
      "terms": {
        "field": "tags",
        "order": {
          "product_price_avg_price": "desc"
        }
      },
      "aggs": {
        "product_price_avg_price": {
          "avg": {
            "field": "price"
          }
        }
      }
    }
  }
}


GET /product_index/_search
{
  "size": 0,
  "query": {
    "match": {
      "product_name": "toothbrush"
    }
  },
  "aggs": {
    "proudct_group_by_price": {
      "range": {
        "field": "price",
        "ranges": [
          {
            "from": 0,
            "to": 300
          },
          {
            "from": 300,
            "to": 400
          },
          {
            "from": 400,
            "to": 1000
          }
        ]
      },
      "aggs": {
        "product_group_by_tags": {
          "terms": {
            "field": "tags"
          },
          "aggs": {
            "product_average_price": {
              "avg": {
                "field": "price"
              }
            }
          }
        }
      }
    }
  }
}


POST /bank/_search
{
  "size": 0, 
  "aggs": {
    "masssbalance": {
      "max": {
        "field": "balance"
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "avg_age": {
      "avg": {
        "field": "age",
        "missing": 18
      }
    }
  }
}

<!-- ardinality  值去重计数 -->
POST /bank/_search?size=0
{
  "aggs": {
    "age_count": {
      "cardinality": {
        "field": "age"
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_stats": {
      "stats": {
        "field": "age"
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_stats": {
      "extended_stats": {
        "field": "age"
      }
    }
  }
}

<!--  Percentiles 占比百分位对应的值统计 -->
POST /bank/_search?size=0
{
  "aggs": {
    "age_percents": {
      "percentiles": {
        "field": "age"
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_percents": {
      "percentiles": {
        "field": "age",
        "percents" : [95, 99, 99.9] 
      }
    }
  }
}


<!-- 字段值项分组聚合  -->
POST /bank/_search?size=0
{
  "aggs": {
    "age_terms": {
      "terms": {
        "field": "age"
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_terms": {
      "terms": {
        "field": "age",
        "size": 20
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_terms": {
      "terms": {
        "field": "age",
        "order" : { "_count" : "asc" }
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "age_terms": {
      "filter": {"match":{"gender":"F"}},
      "aggs": {
        "avg_age": {
          "avg": {
            "field": "age"
          }
        }
      }
    }
  }
}

POST /bank/_search?size=0
{
  "aggs": {
    "sales_over_time": {
      "date_histogram": {
        "field": "date",
        "interval": "month"
      }
    }
  }
}

GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "colors": {
         "terms": {
            "field": "color"
         },
         "aggs": { 
            "avg_price": { 
               "avg": {
                  "field": "price" 
               }
            }
         }
      }
   }
}

GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "colors": {
         "terms": {
            "field": "color"
         },
         "aggs": {
            "avg_price": { 
               "avg": {
                  "field": "price"
               }
            },
            "make": { 
                "terms": {
                    "field": "make" 
                }
            }
         }
      }
   }
}


GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "colors": {
         "terms": {
            "field": "color"
         },
         "aggs": {
            "avg_price": { "avg": { "field": "price" }
            },
            "make" : {
                "terms" : {
                    "field" : "make"
                },
                "aggs" : { 
                    "min_price" : { "min": { "field": "price"} }, 
                    "max_price" : { "max": { "field": "price"} } 
                }
            }
         }
      }
   }
}


GET /cars/transactions/_search
{
   "size" : 0,
   "aggs":{
      "price":{
         "histogram":{ 
            "field": "price",
            "interval": 20000
         },
         "aggs":{
            "revenue": {
               "sum": { 
                 "field" : "price"
               }
             }
         }
      }
   }
}


GET /cars/transactions/_search
{
  "size" : 0,
  "aggs": {
    "makes": {
      "terms": {
        "field": "make",
        "size": 10
      },
      "aggs": {
        "stats": {
          "extended_stats": {
            "field": "price"
          }
        }
      }
    }
  }
}


GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "sales": {
         "date_histogram": {
            "field": "sold",
            "interval": "month", 
            "format": "yyyy-MM-dd" 
         }
      }
   }
}

GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "sales": {
         "date_histogram": {
            "field": "sold",
            "interval": "quarter", 
            "format": "yyyy-MM-dd",
            "min_doc_count" : 0,
            "extended_bounds" : {
                "min" : "2014-01-01",
                "max" : "2014-12-31"
            }
         },
         "aggs": {
            "per_make_sum": {
               "terms": {
                  "field": "make"
               },
               "aggs": {
                  "sum_price": {
                     "sum": { "field": "price" } 
                  }
               }
            },
            "total_sum": {
               "sum": { "field": "price" } 
            }
         }
      }
   }
}


