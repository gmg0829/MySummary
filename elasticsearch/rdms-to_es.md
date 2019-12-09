## 关系数据库到es

使用 logstash-input-jdbc
### 下载mysql驱动
将驱动文件放到logstash根目录下。
### 在conf目录下配置mysqlsyn.conf
```
input {
    jdbc {
        # jdbc驱动包位置
        jdbc_driver_library => "/usr/local/logstash-7.2.0/mysql-connector-java-6.0.6.jar"
        # 要使用的驱动包类，有过java开发经验的应该很熟悉这个了，不同的数据库调用的类不一样。
        jdbc_driver_class => "com.mysql.jdbc.Driver"
        # myqsl数据库的连接信息
        jdbc_connection_string => "jdbc:mysql://localhost:3306/myapp"
        # mysql用户
        jdbc_user => "root"
        # mysql密码
        jdbc_password => "root"
        # 定时任务， 多久执行一次查询, 默认一分钟，如果想要没有延迟，可以使用 schedule => "* * * * * *"
        schedule => "* * * * *"
        # 你要执行的语句
        statement => "select * from user"
    }
}

output {
        # 将数据输出到ElasticSearch中
    elasticsearch {
        # es ip加端口
        hosts => ["192.168.254.134:9200"]
        # es文档索引
        index => "myusreinfo"
        # es文档数据的id，%{id}代表的是用数据库里面记录的id作为文档的id
        document_id => "%{id}"
    }
}

```
### 修改logstash jdk版本为1.8

在logstash和logstash.lib.sh文件添加
```
export JAVA_CMD="/usr/local/jdk1.8.0_221/bin"  
export JAVA_HOME="/usr/local/jdk1.8.0_221/"
```
### 执行
```
-f 指定配置文件启动

nohup ./bin/logstash -f config/mysqlsyn.conf &
```
### 参考

https://juejin.im/post/5d1886d4e51d45775b419c22

https://blog.csdn.net/laoyang360/article/details/51694519

https://juejin.im/post/5ce3948551882532ea6d771a#heading-13


