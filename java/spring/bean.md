其中 BeanFactory 作为最顶层的一个接口类，它定义了IOC容器的基本功能规范。

BeanFactory有三个直接的子类：ListableBeanFactory、HierarchicalBeanFactory 和 AutowireCapableBeanFactory。

ListableBeanFactory接口表示这些Bean是可列表的，而 HierarchicalBeanFactory表示的是这些Bean是有继承关系的，也就是每个Bean 有可能有父Bean。AutowireCapableBeanFactory接口定义 Bean 的自动装配规则。

 ApplicationContext是Spring提供的一个高级的IOC容器，它除了能够提供 IOC 容器的基本功能外，还为用户提供了以下的附加服务。

从 ApplicationContext 接口的实现，我们看出其特点：
- 1.支持信息源，可以实现国际化。（实现 MessageSource 接口）
- 2.访问资源。(实现 ResourcePatternResolver 接口)
- 3.支持应用事件。(实现 ApplicationEventPublisher 接口)

## BeanDefinition

SpringIOC 容器管理了我们定义的各种 Bean 对象及其相互的关系，Bean 对象在 Spring 实现中是以 BeanDefinition来描述的

  ![bean-digram](
  ./bean-digram.jpg)
