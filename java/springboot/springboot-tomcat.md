## WebServer 自动配置
ServletWebServerFactoryAutoConfiguration

## TomcatServletWebServerFactory

其中最核心的方法就是 getWebServer，获取一个 WebServer 对象实例。
prepareContext 做的事情就是将 web 应用映射到一个 TomcatEmbeddedContext ，然后加入到 Host 中。