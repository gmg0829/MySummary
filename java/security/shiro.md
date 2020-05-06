## 简介
Apache Shiro是一个功能强大且灵活的开源安全框架，它可以处理身份验证、授权、企业会话管理和加密。

  ![ShiroFeatures](
  ./ShiroFeatures.png)

## 架构 
### 基础架构
在最高的概念层次上，Shiro的架构有三个主要概念：主题、安全管理器和领域。

![ShiroBasicArchitecture](
  ./ShiroBasicArchitecture.png)

应用代码通过 Subject 来进行认证和授权，而 Subject 又委托给 SecurityManager； 我们需要给 Shiro 的 SecurityManager 注入 Realm，从而让 SecurityManager 能得到合法
的用户及其权限进行判断。

### 详细架构
![ShiroArchitecture](
  ./ShiroArchitecture.png)

- Subject：主体，可以看到主体可以是任何可以与应用交互的 “用户”。
- SecurityManager：相当于 SpringMVC 中的 DispatcherServlet 或者 Struts2 中的 FilterDispatcher；是 Shiro 的心脏；所有具体的交互都通过 SecurityManager 进行控制；它管理着所有 Subject、且负责进行认证和授权、及会话、缓存的管理。
- 认证器，负责主体认证的，这是一个扩展点，如果用户觉得 Shiro 默认的不好，可以自定义实现；其需要认证策略（Authentication Strategy），即什么情况下算用户认证通过了；
- Authorizer：授权器，或者访问控制器，用来决定主体是否有权限进行相应的操作；即控制着用户能访问应用中的哪些功能；
- SessionManager：如果写过 Servlet 就应该知道 Session 的概念，Session 呢需要有人去管理它的生命周期，这个组件就是 SessionManager；而 Shiro 并不仅仅可以用在 Web 环境，也可以用在如普通的 JavaSE 环境、EJB 等环境；所有呢，Shiro 就抽象了一个自己的 Session 来管理主体与应用之间交互的数据。
- CacheManager：缓存控制器，来管理如用户、角色、权限等的缓存的；因为这些数据基本上很少去改变，放到缓存中后可以提高访问的性能
- Cryptography：密码模块，Shiro 提高了一些常见的加密组件用于如密码加密 / 解密的。
- Realm：可以有 1 个或多个 Realm，可以认为是安全实体数据源，即用于获取安全实体的；可以是 JDBC 实现，也可以是 LDAP 实现，或者内存实现等等；由用户提供；注意：Shiro 不知道你的用户 / 权限存储在哪及以何种格式存储；所以我们一般在应用中都需要实现自己的 Realm。
- SessionDAO：DAO 大家都用过，数据访问对象，用于会话的 CRUD，比如我们想把 Session 保存到数据库，那么可以实现自己的 SessionDAO，通过如 JDBC 写到数据库；比如想把 Session 放到 Memcached 中，可以实现自己的 Memcached SessionDAO；另外 SessionDAO 中可以使用 Cache 进行缓存，以提高性能；

### 核心类
- SecurityManager：安全管理器，Shiro最核心组件。Shiro通过SecurityManager来管理内部组件实例，并通过它来提供安全管理的各种服务。
- Authenticator：认证器，认证AuthenticationToken是否有效。
- Authorizer：授权器，处理角色和权限。
- SessionManager：Session管理器，管理Session。
- Subject：当前操作主体，表示当前操作用户。
- SubjectContext：Subject上下文数据对象。
- AuthenticationToken：认证的token信息(用户名、密码等)。
- ThreadContext：线程上下文对象，负责绑定对象到当前线程。




