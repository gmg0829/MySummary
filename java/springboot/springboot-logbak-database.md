## Springboot集成logback将错误日志同步到数据库

环境： springboot+logback+oracle

### 配置pom.xml
```
<!--Oracle 驱动 -->
<dependency>
    <groupId>com.oracle</groupId>
    <artifactId>ojdbc6</artifactId>
    <version>11.2.0.3</version>
</dependency>
<!--druid 数据库连接池 -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.1.10</version>
</dependency>
```

### 创建数据表
在scrip下找到自己数据库所需的sql文件即可，连接为： https://github.com/qos-ch/logback/blob/master/logback-classic/src/main/resources/ch/qos/logback/classic/db/script/oracle.sql

共三张表，分别是：LOGGING_EVENT、LOGGING_EVENT_EXCEPTION、LOGGING_EVENT_PROPERTY。

由于使用的数据库为oracle,所以选择oracle.sql。

### logbcak-spring.xml 配置

```
 <!-- 将日志写入数据库 -->
    <appender name="DB-ORACLE-POOL" class="ch.qos.logback.classic.db.DBAppender">
        <connectionSource class="ch.qos.logback.core.db.DataSourceConnectionSource">
            <dataSource class="com.alibaba.druid.pool.DruidDataSource">
                <driverClassName>oracle.jdbc.OracleDriver</driverClassName>
                <url>jdbc:oracle:thin:@xxx.xx.xx:3221:xe</url>
                <username>xxxxx</username>
                <password>xxxx</password>
            </dataSource>
        </connectionSource>
        <!--这里设置日志级别为error-->
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>error</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
    </appender>

    <!-- 日志输出级别 -->
    <root level="INFO">
        <appender-ref ref="DB-ORACLE-POOL"/>

    </root>

```
### 测试
```
Logger logger = LoggerFactory.getLogger(userController.class);

logger.info("info日志");
logger.error("error日志");

```
### 查看数据表

发现error级别日志插入到数据表，而info级别的没有。

![logback-error](
  ./logback-error.jpg)

由于数据库存的是时间戳，我们希望看的时间是YYYY-MM-DD HH24:MI:SS。转换语句为
```
SELECT TO_CHAR(TIMESTMP / (1000 * 60 * 60 * 24) 
       TO_DATE('1970-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') AS CDATE  
FROM LOGGING_EVENT t;  
```

### 用途
我把该功能可以用在离线任务中。可以快速定位问题出现的原因和位置。