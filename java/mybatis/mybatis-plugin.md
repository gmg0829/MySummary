## mybatis 插件机制
与其称为Mybatis插件，不如叫Mybatis拦截器，更加符合其功能定位，实际上它就是一个拦截器，应用代理模式，在方法级别上进行拦截。

支持拦截的方法
- 执行器Executor（update、query、commit、rollback等方法）；
- 参数处理器ParameterHandler（getParameterObject、setParameters方法）；
- 结果集处理器ResultSetHandler（handleResultSets、handleOutputParameters等方法）；
- SQL语法构建器StatementHandler（prepare、parameterize、batch、update、query等方法）

Mybatis插件的实现机制主要是基于动态代理实现的，其中最为关键的就是代理对象的生成，所以有必要来了解下这些代理对象是如何生成的。

![mybatis-plugin](
  ./mybatis-plugin-1.png)

### 插件配置信息的加载  
![mybatis-plugin](
  ./mybatis-plugin-2.png)

### 代理对象的生成
![mybatis-plugin](
  ./mybatis-plugin-3.png)

### 应用场景
- 分页功能
mybatis的分页默认是基于内存分页的（查出所有，再截取），数据量大的情况下效率较低，不过使用mybatis插件可以改变该行为，只需要拦截StatementHandler类的prepare方法，改变要执行的SQL语句为分页语句即可。
- 公共字段统一赋值
一般业务系统都会有创建者，创建时间，修改者，修改时间四个字段，对于这四个字段的赋值，实际上可以在DAO层统一拦截处理，可以用mybatis插件拦截Executor类的update方法，对相关参数进行统一赋值即可；
- 性能监控
对于SQL语句执行的性能监控，可以通过拦截Executor类的update, query等方法，用日志记录每个方法执行的时间；

- 其它
其实mybatis扩展性还是很强的，基于插件机制，基本上可以控制SQL执行的各个阶段，如执行阶段，参数处理阶段，语法构建阶段，结果集处理阶段，具体可以根据项目业务来实现对应业务逻辑。

