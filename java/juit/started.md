## 注解列表
@RunWith：标识为JUnit的运行环境；缺省值 org.junit.runner.Runner
@SpringBootTest：获取启动类、加载配置，确定装载Spring Boot；
@Test：声明需要测试的方法；
@BeforeClass：针对所有测试，只执行一次，且必须为static void；
@AfterClass：针对所有测试，只执行一次，且必须为static void；
@Before：每个测试方法前都会执行的方法；
@After：每个测试方法前都会执行的方法；
@Ignore：忽略方法；
@InjectMocks
@ParameterizedTest
@ValueSource(strings = {"/com/example/demo/LocalClassLoader/evosuite.json"})
@BeforeEach
@MockBean
@Mock


超时测试
@Test(timeout = 1000)
异常测试
@Test(expected = NullPointerException.class)
套件测试
@RunWith(Suite.class) // 1. 更改测试运行方式为 Suite
// 2. 将测试类传入进来
@Suite.SuiteClasses({TaskOneTest.class, TaskTwoTest.class, TaskThreeTest.class})




## 断言测试
断言测试也就是期望值测试，是单元测试的核心也就是决定测试结果的表达式，Assert对象中的断言方法：
Assert.assertEquals 对比两个值相等
Assert.assertNotEquals 对比两个值不相等
Assert.assertSame 对比两个对象的引用相等
Assert.assertArrayEquals 对比两个数组相等
Assert.assertTrue 验证返回是否为真
Assert.assertFlase 验证返回是否为假
Assert.assertNull 验证null
Assert.assertNotNull 验证非null



## Web模拟测试
在Spring Boot项目里面可以直接使用JUnit对web项目进行测试，Spring 提供了“TestRestTemplate”对象，使用这个对象可以很方便的进行模拟请求。

Web测试只需要进行两步操作：

在@SpringBootTest注解上设置“ebEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT”随机端口；
使用TestRestTemplate进行post或get请求；
示例代码如下：

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class UserControllerTest {
    @Autowired
    private TestRestTemplate restTemplate;
    @Test
    public void getName() {
        String name = restTemplate.getForObject("/name", String.class);
        System.out.println(name);
        Assert.assertEquals("Adam", name);
    }
}

## 数据库测试
在测试数据操作的时候，我们不想让测试污染数据库，也是可以实现的，只需要添加给测试类上添加“@Transactional”即可，这样既可以测试数据操作方法，又不会污染数据库了。

## Spring MVC 测试
当你想对 Spring MVC 控制器编写单元测试代码时，可以使用@WebMvcTest注解。它提供了自配置的 MockMvc，可以不需要完整启动 HTTP 服务器就可以快速测试 MVC 控制器。
```
@RunWith(SpringRunner.class)
@WebMvcTest(EmployeeController.class)
public class EmployeeController2Test {
    @Autowired
    private MockMvc mvc;

    @MockBean
    private EmployeeService employeeService;

    public void setUp() {
        // 数据打桩，设置该方法返回的 body一直 是空的
        Mockito.when(employeeService.findEmployee()).thenReturn(new ArrayList<>());
    }

    @Test
    public void listAll() throws Exception {
        mvc.perform(MockMvcRequestBuilders.get("/emp"))
                .andExpect(status().isOk()) // 期待返回状态吗码200
                // JsonPath expression  https://github.com/jayway/JsonPath
                //.andExpect(jsonPath("$[1].name").exists()) // 这里是期待返回值是数组，并且第二个值的 name 存在，所以这里测试是失败的
                .andDo(print()); // 打印返回的 http response 信息
    }
}
```

## Mockito

Mockito.mock(classToMock)	模拟对象
Mockito.verify(mock)	验证行为是否发生
Mockito.when(methodCall).thenReturn(value1).thenReturn(value2)	触发时第一次返回value1，第n次都返回value2
Mockito.doThrow(toBeThrown).when(mock).[method]	模拟抛出异常。
Mockito.mock(classToMock,defaultAnswer)	使用默认Answer模拟对象
Mockito.when(methodCall).thenReturn(value)	参数匹配
Mockito.doReturn(toBeReturned).when(mock).[method]	参数匹配（直接执行不判断）
Mockito.when(methodCall).thenAnswer(answer))	预期回调接口生成期望值
Mockito.doAnswer(answer).when(methodCall).[method]	预期回调接口生成期望值（直接执行不判断）
Mockito.spy(Object)	用spy监控真实对象,设置真实对象行为
Mockito.doNothing().when(mock).[method]	不做任何返回
Mockito.doCallRealMethod().when(mock).[method] //等价于Mockito.when(mock.[method]).thenCallRealMethod();	调用真实的方法
reset(mock)	重置mock

