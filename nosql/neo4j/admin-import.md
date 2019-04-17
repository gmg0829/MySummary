## 基本语法
```
neo4j-admin import [--mode=csv] [--database=<name>]
                          [--additional-config=<config-file-path>]
                          [--report-file=<filename>]
                          [--nodes[:Label1:Label2]=<"file1,file2,...">]
                          [--relationships[:RELATIONSHIP_TYPE]=<"file1,file2,...">]
                          [--id-type=<STRING|INTEGER|ACTUAL>]
                          [--input-encoding=<character-set>]
                          [--ignore-extra-columns[=<true|false>]]
                          [--ignore-duplicate-nodes[=<true|false>]]
                          [--ignore-missing-nodes[=<true|false>]]
                          [--multiline-fields[=<true|false>]]
                          [--delimiter=<delimiter-character>]
                          [--array-delimiter=<array-delimiter-character>]
                          [--quote=<quotation-character>]
                          [--max-memory=<max-memory-that-importer-can-use>]
                          [--f=<File containing all arguments to this import>]
                          [--high-io=<true/false>]
```

## 导入数据

```
bin/neo4j-admin import --nodes:Movie import/movie_node.csv --delimiter ";" --array-delimiter "|" --quote "'"
```

通过neo4j-admin方式导入的话，需要暂停服务，并且需要清除graph.db,这样才能导入进去数据。而且，只能在初始化数据时，导入一次之后，就不能再次导入。

所以这种方式，可以在初次建库的时候，导入大批量数据，等以后如果还需要导入数据时，可以采用上边的方法

## 重启neo4j容器
```
docker restart xx
```

```
CALL apoc.periodic.iterate(
    'CALL apoc.load.csv("{filename}") yield map as row return row'
    ,'merge (n:{label} {pid:row.pid}) with *
    merge (n_e:{label_end} {pid:row.pid_end}) with *
    merge (n)-[r:watching]->(n_e) '
    ,'{batchSize:10000, iterateList:true, parallel:true}'
    )
	;
```

https://blog.csdn.net/wenxuechaozhe/article/details/80548835

https://blog.csdn.net/linsea/article/details/83463213


```
WITH 'https://raw.githubusercontent.com/neo4j-contrib/neo4j-apoc-procedures/3.3.0.2/src/test/resources/person.json' AS url
CALL apoc.load.json(url) YIELD value as person
MERGE (p:Person {name:person.name})
   ON CREATE SET p.age = person.age,  p.children = size(person.children);
```

```
CALL apoc.load.json("/neo4jJson/agency.json") YIELD value as agency
            MERGE (a:Agency {name:agency.name})
            ON CREATE SET a.age = agency.age
            ON MATCH SET a.age = agency.age
            return count(*)
```

```
CALL apoc.load.json("/neo4jJson/re.json") YIELD value as re
        MATCH (cust:Customer{id:re.cid}),(cc:CreditCard{id:re.did})
        merge (cust)-[r:DO_SHOPPING{name:re.rName}]->(cc)
        return count(*)
```


```
所以最好把csv文件放到import目录下，注意，事先，进入$NEO_HOME/conf/neo4j.conf配置文件并取消这一行的注释：

dbms.directories.import=import

开启引入文件

apoc.import.file.enabled=true
```

mvn package -Dmaven.test.skip=true  
















