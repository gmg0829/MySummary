工作流涉及到服务提供者（Provider），注册中心（Registration），网络（Network）和服务消费者（Consumer）：

- 服务提供者在启动的时候，会通过读取一些配置将服务实例化。
- Proxy 封装服务调用接口，方便调用者调用。客户端获取 Proxy 时，可以像调用本地服务一样，调用远程服务。
- Proxy 在封装时，需要调用 Protocol 定义协议格式，例如：Dubbo Protocol。
-  将 Proxy 封装成 Invoker，它是真实服务调用的实例。
- 将 Invoker 转化成 Exporter，Exporter 只是把 Invoker 包装了一层，是为了在注册中心中暴露自己，方便消费者使用。
将包装好的 Exporter 注册到注册中心。
-  服务消费者建立好实例，会到服务注册中心订阅服务提供者的元数据。元数据包括服务 IP 和端口以及调用方式（Proxy）。
- 消费者会通过获取的 Proxy 进行调用。通过服务提供方包装过程可以知道，Proxy 实际包装了 Invoker 实体，因此需要使用 Invoker 进行调用。
- 在 Invoker 调用之前，通过 Directory 获取服务提供者的 Invoker 列表。在分布式的服务中有可能出现同一个服务，分布在不同的节点上。
通过路由规则了解，服务需要从哪些节点获取。
- Invoker 调用过程中，通过 Cluster 进行容错，如果遇到失败策略进行重试。
- 调用中，由于多个服务可能会分布到不同的节点，就要通过 LoadBalance 来实现负载均衡。
I- nvoker 调用之前还需要经过 Filter，它是一个过滤链，用来处理上下文，限流和计数的工作。
生成过滤以后的 Invoker。
- 用 Client 进行数据传输。
- Codec 会根据 Protocol 定义的协议，进行协议的构造。
- 构造完成的数据，通过序列化 Serialization 传输给服务提供者。
- Request 已经到达了服务提供者，它会被分配到线程池（ThreadPool）中进行处理。
- Server 拿到请求以后查找对应的 Exporter（包含有 Invoker）。
- 由于 Export 也会被 Filter 层层包裹
- 通过 Filter 以后获得 Invoker
- 最后，对服务提供者实体进行调用。

Proxy 是用来方便调用者调用的。Invoker 是在调用具体实体时使用的。Exporter 用来注册到注册中心的.
 ![dubbo-source](
  ./dubbo-core.jpg)
## 服务暴露实现原理
   ![dubbo-source](
  ./dubbo-server.jpg)
## 服务消费者原理
 ![dubbo-source](
  ./dubbo-client.jpg)
## 注册中心工作原理:
 
它通过树形文件存储的 ZNode 在 /dubbo/Service 目录下面建立了四个目录，分别是：

- Providers 目录下面，存放服务提供者 URL 和元数据。
- Consumers 目录下面，存放消费者的 URL 和元数据。
- Routers 目录下面，存放消费者的路由策略。
- Configurators 目录下面，存放多个用于服务提供者动态配置 URL 元数据信息。

## Dubbo 集群容错:

Dubbo 的负载均衡策略有四种：

Random LoadBalance，随机，按照权重设置随机概率做负载均衡。
RoundRobinLoadBalance，轮询，按照公约后的权重设置轮询比例。
LeastActiveLoadBalance，按照活跃数调用，活跃度差的被调用的次数多。活跃度相同的 Invoker 进行随机调用。
ConsistentHashLoadBalance，一致性 Hash，相同参数的请求总是发到同一个提供者。
最后进行 RPC 调用。如果调用出现异常，针对不同的异常提供不同的容错策略。Cluster 接口定义了 9 种容错策略，这些策略对用户是完全透明的。

用户可以在标签上通过 Cluster 属性设置：

Failover，出现失败，立即重试其他服务器。可以设置重试次数。
Failfast，请求失败以后，返回异常结果，不进行重试。
Failsafe，出现异常，直接忽略。
Failback，请求失败后，将失败记录放到失败队列中，通过定时线程扫描该队列，并定时重试。
Forking，尝试调用多个相同的服务，其中任意一个服务返回，就立即返回结果。
Broadcast，广播调用所有可以连接的服务，任意一个服务返回错误，就任务调用失败。
Mock，响应失败时返回伪造的响应结果。
Available，通过遍历的方式查找所有服务列表，找到第一个可以返回结果的节点，并且返回结果。
Mergable，将多个节点请求合并进行返回。

## 扩展点加载

Dubbo 改进了 JDK 标准的 SPI 的以下问题：

- JDK 标准的 SPI 会一次性实例化扩展点所有实现，如果有扩展实现初始化很耗时，但如果没用上也加载，会很浪费资源。
- 如果扩展点加载失败，连扩展点的名称都拿不到了。比如：JDK 标准的 ScriptEngine，通过 getName() 获取脚本类型的名称，但如果 RubyScriptEngine 因为所依赖的 jruby.jar 不存在，导致 RubyScriptEngine 类加载失败，这个失败原因被吃掉了，和 ruby 对应不起来，当用户执行 ruby 脚本时，会报不支持 ruby，而不是真正失败的原因。
- 增加了对扩展点 IoC 和 AOP 的支持，一个扩展点可以直接 setter 注入其它扩展点

ExtensionLoader在Dubbo里的角色类似ServiceLoader在JDK中的存在，用于加载扩展类。在Dubbo源码里，随处都可以见到ExtensionLoader的身影。


