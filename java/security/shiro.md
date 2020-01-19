## 简介

- SecurityManager：安全管理器，Shiro最核心组件。Shiro通过SecurityManager来管理内部组件实例，并通过它来提供安全管理的各种服务。
- Authenticator：认证器，认证AuthenticationToken是否有效。
- Authorizer：授权器，处理角色和权限。
- SessionManager：Session管理器，管理Session。
- Subject：当前操作主体，表示当前操作用户。
- SubjectContext：Subject上下文数据对象。
- AuthenticationToken：认证的token信息(用户名、密码等)。
- ThreadContext：线程上下文对象，负责绑定对象到当前线程。


