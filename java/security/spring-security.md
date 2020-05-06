## 简介
Spring Security是一个功能强大、高度可定制的身份验证和访问控制框架。它实际上是保护基于Spring的应用程序的标准。

Spring Security是一个专注于为Java应用程序提供身份验证和授权的框架。与所有Spring项目一样，Spring安全的真正威力在于它可以很容易地被扩展以满足定制需求。


## SpringSecurity 过滤器链
SpringSecurity 采用的是责任链的设计模式，它有一条很长的过滤器链。现在对这条过滤器链的各个进行说明:

- WebAsyncManagerIntegrationFilter：将 Security 上下文与 Spring Web 中用于处理异步请求映射的 WebAsyncManager 进行集成。

- SecurityContextPersistenceFilter：在每次请求处理之前将该请求相关的安全上下文信息加载到 SecurityContextHolder 中，然后在该次请求处理完成之后，将 SecurityContextHolder 中关于这次请求的信息存储到一个“仓储”中，然后将 SecurityContextHolder 中的信息清除，例如在Session中维护一个用户的安全信息就是这个过滤器处理的。

- HeaderWriterFilter：用于将头信息加入响应中。

- CsrfFilter：用于处理跨站请求伪造。

- LogoutFilter：用于处理退出登录。

- UsernamePasswordAuthenticationFilter：用于处理基于表单的登录请求，从表单中获取用户名和密码。默认情况下处理来自 /login 的请求。从表单中获取用户名和密码时，默认使用的表单 name 值为 username 和 password，这两个值可以通过设置这个过滤器的usernameParameter 和 passwordParameter 两个参数的值进行修改。

- DefaultLoginPageGeneratingFilter：如果没有配置登录页面，那系统初始化时就会配置这个过滤器，并且用于在需要进行登录时生成一个登录表单页面。

- BasicAuthenticationFilter：检测和处理 http basic 认证。

- RequestCacheAwareFilter：用来处理请求的缓存。

- SecurityContextHolderAwareRequestFilter：主要是包装请求对象request。

- AnonymousAuthenticationFilter：检测 SecurityContextHolder 中是否存在 Authentication 对象，如果不存在为其提供一个匿名 Authentication。

- SessionManagementFilter：管理 session 的过滤器

- ExceptionTranslationFilter：处理 AccessDeniedException 和 AuthenticationException 异常。

- FilterSecurityInterceptor：可以看做过滤器链的出口。

- RememberMeAuthenticationFilter：当用户没有登录而直接访问资源时, 从 cookie 里找出用户的信息, 如果 Spring Security 能够识别出用户提供的remember me cookie, 用户将不必填写用户名和密码, 而是直接登录进入系统，该过滤器默认不开启。

  ![spring-security](
  ./spring-security.png)

## 核心组件
### SecurityContextHolder
SecurityContextHolder用于存储安全上下文（security context）的信息。当前操作的用户是谁，该用户是否已经被认证，他拥有哪些角色权限…这些都被保存在SecurityContextHolder中。

### Authentication

authentication.getPrincipal()返回了一个Object，我们将Principal强转成了Spring Security中最常用的UserDetails。

Spring Security是如何完成身份认证的？
1 用户名和密码被过滤器获取到，封装成Authentication,通常情况下是UsernamePasswordAuthenticationToken这个实现类。

2 AuthenticationManager 身份管理器负责验证这个Authentication

3 认证成功后，AuthenticationManager身份管理器返回一个被填充满了信息的（包括上面提到的权限信息，身份信息，细节信息，但密码通常会被移除）Authentication实例。

4 SecurityContextHolder安全上下文容器将第3步填充了信息的Authentication，通过SecurityContextHolder.getContext().setAuthentication(…)方法，设置到其中。

### AuthenticationManager
AuthenticationManager是一个用来处理认证（Authentication）请求的接口。在其中只定义了一个方法authenticate()，该方法只接收一个代表认证请求的Authentication对象作为参数，如果认证成功，则会返回一个封装了当前用户权限等信息的Authentication对象进行返回。

### UserDetailsService
UserDetails是Spring Security中一个核心的接口。其中定义了一些可以获取用户名、密码、权限等与认证相关的信息的方法。

### GrantedAuthority
Authentication的getAuthorities()可以返回当前Authentication对象拥有的权限，即当前用户拥有的权限。
## Spring Security OAuth2
Spring Security OAuth2 建立在 Spring Security Core 和 Spring Security Web 的基础上，提供了对 OAuth2 授权框架的支持。

## Spring Security JWT

Spring Security JWT 在 Spring Security OAuth2 中便扮演了 TokenService 和 TokenStore 的角色，用于生成和效验 Token。


## 参考链接

http://www.iocoder.cn/Spring-Security/laoxu/Architecture-Overview/

https://www.cnblogs.com/rgbit/p/11784371.html
