## Java 正则
### Pattern
Pattern p=Pattern.compile("\\w+"); 
p.pattern();//返回 \w+ 

Pattern p=Pattern.compile("\\d+"); 
String[] str=p.split("我的QQ是:456456我的电话是:0532214我的邮箱是:aaa@aaa.com");

Pattern.matches("\\d+","2223");//返回true 
Pattern.matches("\\d+","2223aa");//返回false,需要匹配到所有字符串才能返回true,这里aa不能匹配到 
Pattern.matches("\\d+","22bb23");//返回false,需要匹配到所有字符串才能返回true,这里bb不能匹配到 


Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("22bb23"); 
m.matches();//返回false,因为bb不能被\d+匹配,导致整个字符串匹配未成功. 
Matcher m2=p.matcher("2223"); 
m2.matches();//返回true,因为\d+匹配到了整个字符串

Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("22bb23"); 
m.lookingAt();//返回true,因为\d+匹配到了前面的22 
Matcher m2=p.matcher("aa2223"); 
m2.lookingAt();//返回false,因为\d+不能匹配前面的aa 


Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("22bb23"); 
m.find();//返回true 

#### Mathcer.start()/ Matcher.end()/ Matcher.group()

- start()返回匹配到的子字符串在字符串中的索引位置. 
- end()返回匹配到的子字符串的最后一个字符在字符串中的索引位置. 
- group()返回匹配到的子字符串 

Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("aaa2223bb"); 
m.find();//匹配2223 
m.start();//返回3 
m.end();//返回7,返回的是2223后的索引号 
m.group();//返回2223 

Mathcer m2=m.matcher("2223bb"); 
m.lookingAt();   //匹配2223 
m.start();   //返回0,由于lookingAt()只能匹配前面的字符串,所以当使用lookingAt()匹配时,start()方法总是返回0 
m.end();   //返回4 
m.group();   //返回2223 

Matcher m3=m.matcher("2223bb"); 
m.matches();   //匹配整个字符串 
m.start();   //返回0,原因相信大家也清楚了 
m.end();   //返回6,原因相信大家也清楚了,因为matches()需要匹配所有字符串 
m.group();   //返回2223bb 

Pattern p=Pattern.compile("([a-z]+)(\\d+)"); 
Matcher m=p.matcher("aaa2223bb"); 
m.find();   //匹配aaa2223 
m.groupCount();   //返回2,因为有2组 
m.start(1);   //返回0 返回第一组匹配到的子字符串在字符串中的索引号 
m.start(2);   //返回3 
m.end(1);   //返回3 返回第一组匹配到的子字符串的最后一个字符在字符串中的索引位置. 
m.end(2);   //返回7 
m.group(1);   //返回aaa,返回第一组匹配到的子字符串 
m.group(2);   //返回2223,返回第二组匹配到的子字符串 

Pattern p=Pattern.compile("\\d+"); 
Matcher m=p.matcher("我的QQ是:456456 我的电话是:0532214 我的邮箱是:aaa123@aaa.com"); 
while(m.find()) { 
     System.out.println(m.group()); 
} 

## 正则表达式语法

两个 \\ 代表其他语言中的一个 \，这也就是为什么表示一位数字的正则表达式是 \\d，而表示一个普通的反斜杠是 \\\\。

## 特殊字符
- $	匹配输入字符串的结尾位置。多行属性，则 $ 也匹配 '\n' 或 '\r'。要匹配 $ 字符本身，请使用 \$。
- ()	标记一个子表达式的开始和结束位置。子表达式可以获取供以后使用。要匹配这些字符，请使用 \( 和 \)。
- *	匹配前面的子表达式零次或多次。要匹配 * 字符，请使用 \*。
- +	匹配前面的子表达式一次或多次。要匹配 + 字符，请使用 \+。
- .	匹配除换行符 \n 之外的任何单字符。要匹配 . ，请使用 \. 。
- [	标记一个中括号表达式的开始。要匹配 [，请使用 \[。
- ?	匹配前面的子表达式零次或一次，或指明一个非贪婪限定符。要匹配 ? 字符，请使用 \?。
- \	将下一个字符标记为或特殊字符、或原义字符、或向后引用、或八进制转义符。例如， 'n' 匹配字符 'n'。'\n' 匹配换行符。序列 '\\' 匹配 "\"，而 '\(' 则匹配 "("。    
- ^	标记限定符表达式的开始。要匹配 {，请使用 \{。
- |	指明两项之间的一个选择。要匹配 |，请使用 \|。


## 限定符
有 * 或 + 或 ? 或 {n} 或 {n,} 或 {n,m} 共6种。

- *	匹配前面的子表达式零次或多次。例如，zo* 能匹配 "z" 以及 "zoo"。* 等价于{0,}。
- +	匹配前面的子表达式一次或多次。例如，'zo+' 能匹配 "zo" 以及 "zoo"，但不能匹配 "z"。+ 等价于 {1,}。
- ?	匹配前面的子表达式零次或一次。例如，"do(es)?" 可以匹配 "do" 、 "does" ， "does" 、 "doxy" 中的 "do" 。? 等价于 {0,1}。
- {n}	n 是一个非负整数。匹配确定的 n 次。例如，'o{2}' 不能匹配 "Bob" 中的 'o'，但是能匹配 "food" 中的两个 o。
- {n,}	n 是一个非负整数。至少匹配n 次。例如，'o{2,}' 不能匹配 "Bob" 中的 'o'，但能匹配 "foooood" 中的所有 o。'o{1,}' 等价于 'o+'。'o{0,}' 则等价于 'o*'。
- {n,m}	m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次。例如，"o{1,3}" 将匹配 "fooooood" 中的前三个 o。'o{0,1}' 等价于 'o?'。请注意在逗号和两个数之间不能有空格。







