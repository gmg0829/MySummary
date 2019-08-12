## DDD-领域驱动设计

参考DDD的设计，DDD官方的架构草图，总体架构分为四层，Infrastructure(基础实施层)，Domain(领域层)，Application(应用层)，Interfaces(表示层，也叫用户界面层或是接口层)。

 ![s](
  ./img/DDD.png)

在领域驱动设计中根据重要性与功能属性将领域分为三类子域，分别是：核心子域、支撑子域和通用子域。决定产品和企业独特竞争力的子域是核心子域，它是业务成功的主要因素和企业的核心竞争力。没有个性化的诉求，属于通用功能的子域是通用子域，如登陆认证。 还有一种所提供的功能是必须的，但不是通用也不是企业核心竞争力的子域是支撑子域，如单证。

 ![s](
  ./img/ddd-a.jpeg)




首先确定核心域,确定完核心子域后，根据对这个领域的理解划分出各个上下文，然后根据上下文再确定其他的相关领域。


## 用DDD走出设计微服务拆分困境


所谓的微服务拆分困难，其实根本原因是不知道边界在什么地方。而使用DDD对业务分析的时候，首先会使用聚合这个概念把关联性强的业务概念划分在一个边界下，并限定聚合和聚合之间只能通过聚合根来访问，这是第一层边界。然后在聚合基础之上根据业务相关性，业务变化频率，组织结构等等约束条件来定义限界上下文，这是第二层边界。有了这两层边界作为约束和限制，微服务的边界也就清晰了，拆分微服务也就不再困难了。

 ![s](
  ./img/ddd-b.jpg)

 ## 参考 

https://www.infoq.cn/article/7QgXyp4Jh3-5Pk6LydWw


https://www.jianshu.com/p/e1b32a5ee91c


http://blog.didispace.com/microservice-three-problem-1/


https://www.jianshu.com/p/d1e4e493012b?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation


https://www.jianshu.com/p/1d5edb64d455


https://blog.csdn.net/u011537073/article/details/73359481


https://www.cnblogs.com/crazylqy/p/7954297.html
