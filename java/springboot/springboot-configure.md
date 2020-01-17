## 自动装配
@EnableAutoConfiguration
@SpringBootConfiguration
@ComponentScan

### @EnableAutoConfiguration
@AutoConfigurationPackage(自动配置包) @Import({Registrar.class}) 导入了一个 Registrar 的组件。AutoConfigurationPackage 注解就是将主配置类（@SpringBootConfiguration标注的类）的所在包及下面所有子包里面的所有组件扫描到Spring容器中。


@Import({AutoConfigurationImportSelector.class}) 该注解给当前配置类导入另外的 N 个自动配置类。

selectImports->getAutoConfigurationEntry() -> getCandidateConfigurations() -> loadFactoryNames()—>
loadSpringFactories()

loadFactoryNames() 中关键的三步：

- 从当前项目的类路径中获取所有 META-INF/spring.factories这个文件下的信息。
- 将上面获取到的信息封装成一个 Map 返回。
- 从返回的 Map 中通过刚才传入的 EnableAutoConfiguration.class参数，获取该 key 下的所有值。
## 手动装配
### 模式注解装配
其实就是使用@Component注解，或者@Component注解的拓展，比如@Controller、@Service、Repository、@Configruation等。
### @Enable模块装配
@EnableXXX模块注入，基于接口驱动实现是实现ImportSelector接口，通过注解参数选择需要导入的配置，而基于注解驱动实现其实就是@Import的派生注解，直接导入某个配置类。
### 条件装配
@ConditionalOnBean
仅仅在当前上下文中存在某个对象时，才会实例化一个Bean
@ConditionalOnExpression
当表达式为true的时候，才会实例化一个Bean
@ConditionalOnMissingClass
某个class类路径上不存在的时候，才会实例化一个Bean
@ConditionalOnNotWebApplication
不是web应用






