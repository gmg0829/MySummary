
## mybatis的if test 字符串的坑

### 问题
```
<if test="type=='y'">  
    and status = 1   
</if>
```

当传入的type的值为1的时候，if判断内的sql也不会执行。

### 原因
mybatis是使用的OGNL表达式来进行解析的，在OGNL的表达式中，'y'会被解析成字符，因为java是强类型的，char 和 一个string 会导致不等。所以if标签中的sql不会被解析。

### 解决办法

只需要把代码修改成：（内双外单）
```
<if test='type=="y"'>  
    and status = 1   
</if>  
```
或者 也可以把代码修改 'y'.toString()

```
<if test="type == 'y'.toString()">  
    and status = 1   
</if>  
```

参考链接： https://blog.csdn.net/xl19961223/article/details/81362696