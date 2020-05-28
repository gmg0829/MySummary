## 什么是架构
把架构拆分成两个字“架”和“构”。“架”就是“加”和“木”的结合，把木头加起来、连接起来就是架。“构”就是结构的意思。所以，“架构”就是把“木“按照一定的结构连接起来。

- 关联到软件领域，木就是系统中的要素，我们将他们称之为架构要素。架构要素可以是子系统、模块、应用服务。
- 结构，是架构的产物。不同的软件系统会有不同的结构，这些结构是为解决不同场景而设计的。
- 连接，通过定义架构元素之间的接口和交互关系、集成机制，实现架构元素之间的连接。连接可以是分布式调用、进程间调用、组件之间的交互关系等。

总结一下架构的本质，即架构 = 要素 + 结构 + 连接，将系统要素按照特定结构进行连接交互。

## 架构域的分类

在软件设计中架构域是如何划分的，架构域包括：业务架构、数据架构、产品架构、应用架构、技术架构。

首先需要熟悉业务，形成业务架构，根据业务架构，做出相应的数据架构和应用架构，最后通过技术架构落地实施。业务架构是战略，应用架构是承上启下，一方面承接业务架构的落地，另一方面影响技术架构的选型。

### 业务架构

在需求初期，业务的需求描述往往比较模糊，可能只是一句话。他们可能来自老板、运营或者用户。

问题域，是指自己的产品能够解决的所有问题的空间集合。从核心需求出发，将所有当前需要解决、未来可能要解决的问题放入产品框架的范围。能够帮助我们的产品拥有更高的可拓展性，在后续具备迭代和优化的空间。

业务架构包括业务规划、业务模块、业务流程，对整个系统的业务进行拆分，对领域模型进行设计，把现实的业务转化成抽象对象。没有最优的架构，只有最合适的架构，一切系统设计原则都要以解决业务问题为最终目标，脱离实际业务的技术情怀架构往往是空中楼阁。

### 数据架构
数据架构主要解决三个问题：第一，系统需要什么样的数据；第二，如何存储这些数据；第三，如何进行数据架构设计。

数据架构中的数据包含静态数据和动态数据。相对静态部分如元数据、业务对象数据模型、主数据、共享数据。相对动态部分如数据流转、ETL、数据全生命周期管控治理。

数据模型最常用的视图就是 ER 图，它主要描述企业数据实体、属性和关系。

- 实体 (Entiy): 企业领域对象
- 属性 (Attribute): 领域对象的属性
- 联系 (RelationShip): 两个领域对象之间的关系 (1:1, 1:n 或者 m:n)

### 产品架构

产品架构中，功能模块是根据其相互之间的关系来组织的。一个产品中不同的功能模块之间的关系分直接关系和间接关系。只有直接关系的功能模块才会被组织到一起，形成一个子系统。那些存在间接关系的模块，会在不同的层级通过直接关系的模块产生联系。

### 应用架构
应用架构是要说明产品架构分哪些应用系统，应用系统间是如何集成的。这就是应用架构和应用集成架构。

### 技术架构

应用架构本身只关心需要哪些应用系统，哪些平台来满足业务目标的需求，而不会关心在整个构建过程中你需要使用哪些技术。技术架构是应接应用架构的技术需求，并根据识别的技术需求，进行技术选型，把各个关键技术和技术之间的关系描述清楚。

技术架构解决的问题包括：如何进行纯技术层面的分层、开发框架的选择、开发语言的选择、涉及非功能性需求的技术选择。由于应用架构体系是分层的，那么对于的技术架构体系自然也是分层的。大的分层有微服务架构分层模型，小的分层则是单个应用的技术分层框架。大的技术体系考虑清楚后，剩下的问题就是根据实际业务场景来选择具体的技术点。各个技术点的分析、方案选择，最终形成关键技术清单，关键技术清单考虑应用架构本身的分层逻辑，最终形成一个完成的技术架构图。

## 参考
https://www.infoq.cn/article/b1fCLl8Mk9L9qe45Zxp6

https://www.infoq.cn/profile/1565818/publish




