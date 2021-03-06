## Spring概述
Spring 总共大约有 20 个模块，由 1300 多个不同的文件构成。而这些组件被分别整合在核心容器
（Core Container）、AOP（Aspect Oriented Programming）和设备支持（Instrmentation）、
数据访问及集成（Data Access/Integeration）、Web、报文发送（Messaging）、Test，6 个模块
集合中。以下是 Spring 5 的模块结构图：

![spring-overview](
  ./spring-overview.png)

## spring源码

 ![spring-source](
  ./spring-source.png)

### 核心模块
- spring-core：依赖注入DI与IOC的最基本实现
- spring-beans：spring所有的bean工厂以及bean的装备都在这里面完成
- spring-context：定义基础的spring的Context上下文也就是IOC容器
- spring-context-support：对spring IOC容器的扩展支持，以及IOC的子容器
- spring-context-indexer：spring的类管理组件和对classpath扫描，类加载路径的管理
- spring-expression：包含spring中所有的表达式语言
### 切面编程

- spring-aop：面向切面编程的应用模块，整合Asm、cglib、jdkProxy

- spring-aspects：集成AspectJ、Aop应用框架

- spring-instrument： 动态class loading 模块，扫描类文件并加载类文件

### 数据访问与集成：

- spring-jdbc：spring提供的jdbc抽象框架的主要实现模块，用于简化spring jdbc操作

- spring-tx：spring jdbc事务控制实现模块

- spring-orm：主要集成hibernate、jpa(java persistence api)、jdo(java data objects)

- spring-oxm：将Java对象映射成xml数据，或者xml转换成java对象

- spring-jms：java messaging service 进行消息的发送与接收

### web组件：

- spring-web：提供了最基础的web支持，主要建立于核心容器之上，通过servlet或者listeners来初始化ioc容器

- spring-webmvc：实现了spring mvc 的web应用
- spring-websocket：主要是与web前端的全双工通讯协议

- spring-webflux：一个新的非堵塞函数式reactive web 框架，可以用来建立异步的，非堵塞的事件驱动服务

### 通信报文：

- spring-messaging：spring4以后新加入的一个模块，主要负责spring框架集成一些基础的报文传送应用

### 集成测试：

- spring-test：主要为测试提供支持

### 集成兼容

- spring-framework-bom：Bill of Materials，解决spring的不同模块依赖版本不同的问题


