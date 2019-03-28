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

