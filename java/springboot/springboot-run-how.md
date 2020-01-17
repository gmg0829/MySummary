###  SpringApplication 的实例化过程
```
public SpringApplication(ResourceLoader resourceLoader, Class<?>... primarySources) {
    // 1、资源初始化资源加载器为 null
    this.resourceLoader = resourceLoader;

    // 2、断言主要加载资源类不能为 null，否则报错
    Assert.notNull(primarySources, "PrimarySources must not be null");

    // 3、初始化主要加载资源类集合并去重
    this.primarySources = new LinkedHashSet<>(Arrays.asList(primarySources));

    // 4、推断当前 WEB 应用类型
    this.webApplicationType = deduceWebApplicationType();

    // 5、设置应用上线文初始化器 如注册属性资源、激活 Profiles 等
    setInitializers((Collection) getSpringFactoriesInstances(
            ApplicationContextInitializer.class));      

    // 6、设置监听器 实现了观察者模式，它一般用来定义感兴趣的事件类型，
    setListeners((Collection) getSpringFactoriesInstances(ApplicationListener.class));

    // 7、推断主入口应用类
    this.mainApplicationClass = deduceMainApplicationClass();

}
```

 ### run方法
 ```
 public ConfigurableApplicationContext run(String... args) {
    // 1、创建并启动计时监控类
    StopWatch stopWatch = new StopWatch();
    stopWatch.start();

    // 2、初始化应用上下文和异常报告集合
    ConfigurableApplicationContext context = null;
    Collection<SpringBootExceptionReporter> exceptionReporters = new ArrayList<>();

    // 3、设置系统属性 `java.awt.headless` 的值，默认值为：true
    configureHeadlessProperty();

    // 4、创建所有 Spring 运行监听器并发布应用启动事件
    SpringApplicationRunListeners listeners = getRunListeners(args);
    listeners.starting();

    try {
        // 5、初始化默认应用参数类
        ApplicationArguments applicationArguments = new DefaultApplicationArguments(
                args);

        // 6、根据运行监听器和应用参数来准备 Spring 环境
        ConfigurableEnvironment environment = prepareEnvironment(listeners,
                applicationArguments);
        configureIgnoreBeanInfo(environment);

        // 7、创建 Banner 打印类
        Banner printedBanner = printBanner(environment);

        // 8、创建应用上下文
        context = createApplicationContext();

        // 9、准备异常报告器
        exceptionReporters = getSpringFactoriesInstances(
                SpringBootExceptionReporter.class,
                new Class[] { ConfigurableApplicationContext.class }, context);

        // 10、准备应用上下文
        prepareContext(context, environment, listeners, applicationArguments,
                printedBanner);

        // 11、刷新应用上下文
        refreshContext(context);

        // 12、应用上下文刷新后置处理
        afterRefresh(context, applicationArguments);

        // 13、停止计时监控类
        stopWatch.stop();

        // 14、输出日志记录执行主类名、时间信息
        if (this.logStartupInfo) {
            new StartupInfoLogger(this.mainApplicationClass)
                    .logStarted(getApplicationLog(), stopWatch);
        }

        // 15、发布应用上下文启动完成事件
        listeners.started(context);

        // 16、执行所有 Runner 运行器
        callRunners(context, applicationArguments);
    }
    catch (Throwable ex) {
        handleRunFailure(context, ex, exceptionReporters, listeners);
        throw new IllegalStateException(ex);
    }

    try {
        // 17、发布应用上下文就绪事件
        listeners.running(context);
    }
    catch (Throwable ex) {
        handleRunFailure(context, ex, exceptionReporters, null);
        throw new IllegalStateException(ex);
    }

    // 18、返回应用上下文
    return context;
}

 ```




https://juejin.im/post/5b8f05a5f265da43296c6102