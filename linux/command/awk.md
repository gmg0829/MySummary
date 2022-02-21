# awk
awk '{pattern + action}' {filenames}


显示2到6行
```
awk 'NR==2,NR==6' boy.txt
```
- $0 代表整个文本行；
- $1 代表文本行中的第 1 个数据字段；
- $2 代表文本行中的第 2 个数据字段；
- $n 代表文本行中的第 n 个数据字段。

awk '{print $1}' data2.txt


```
100.120.34.170 - - [24/Jan/2019:00:06:02 +0800] "GET /page1 HTTP/1.1" 200 29087 "-" "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)" "36.110.179.109" 0.138 0.138
```

### 统计IP和出现过的次数

cat file | awk -F " " '{print $1}' | awk '{cnt[$0]++}END{for(i in cnt){print i,cnt[i]}}'

- -F " ":以空格做分隔符，默认分隔符就是空格，因此可以被省略
- cnt是一个数组，以$0作为key，value每次累加；$0指整行
- END指处理完所有行，再执行后面的逻辑
- for(i in cnt)遍历cnt并打印key和value

### 只对IP进行去重

cat file | awk -F " " '{print $1}' | sort | uniq
cat file | awk '{print $1}' | awk '!a[$0]++'

### 统计平均响应时间
cat file | awk '{a+=$(NF-1);b++}END{print a/b}'

- $NF是最后一个字段，$(NF-1)是倒数第二个字段
- a+=$(NF-1)对所有值累加, b++计数

 awk '{print $9}' access.log | sort | uniq -c | sort
 awk '($9 ~ /404/)' access.log
 
