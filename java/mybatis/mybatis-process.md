## 1 MyBatis主要的类
- Configuration        MyBatis所有的配置信息都维持在Configuration对象之中。
- SqlSession            作为MyBatis工作的主要顶层API，表示和数据库交互的会话，完成必要数据库增删改查功能
- Executor               MyBatis执行器，是MyBatis 调度的核心，负责SQL语句的生成和查询缓存的维护
- StatementHandler 封装了JDBC Statement操作，负责对JDBC statement 的操作，如设置参数、将Statement结果集转换成List集合。
- ParameterHandler  负责对用户传递的参数转换成JDBC Statement 所需要的参数，
- ResultSetHandler   负责将JDBC返回的ResultSet结果集对象转换成List类型的集合；
- TypeHandler          负责java数据类型和jdbc数据类型之间的映射和转换
- MappedStatement  MappedStatement维护了一条<select|update|delete|insert>节点的封装，
- SqlSource              负责根据用户传递的parameterObject，动态地生成SQL语句，将信息封装到BoundSql对象中，并返回
- BoundSql              表示动态生成的SQL语句以及相应的参数信息

通过MapperProxy动态代理咱们的dao， 也就是说， 当咱们执行自己写的dao里面的方法的时候，其实是对应的mapperProxy在代理。

MapperRegistry
SqlSession
MapperProxy
MappedStatement
XMLMapperBuilder

注册：将 Mapper xml 中的节点信息和 Mapper 类中的注解信息与 Mapper 类的方法一一对应，每个方法对应生成一个 MapperStatement，并添加到 Configuration 中；

绑定：根据 Mapper xml 中的 namespace 生成一个 Mapper class 对象，并与一个 MapperProxyFactory 代理工厂对应，用于 Mapper 代理对象的生成。

MappedStatement 类是保存 Mapper 一个执行方法映射的一个节点（select/insert/delete/update），包括配置的 sql，sql 的 id、缓存信息、resultMap、parameterType、resultType 等重要配置内容。


1、通过mybatis环境等配置信息构造SqlSessionFactory即会话工厂
2、由会话工厂创建sqlSession即会话，操作数据库需要通过sqlSession进行。
3、mybatis底层自定义了Executor执行器接口操作数据库，Executor接口有两个实现，一个是基本执行器、一个是缓存执行器。


## 参考
https://www.cnblogs.com/dongying/p/4142476.html

https://blog.csdn.net/weixin_43184769/article/details/91126687

https://objcoding.com/2018/06/01/mybatis-mapper/
