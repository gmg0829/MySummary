## grep 命令
查找

### 递归指定目录下的所有文件查找
```
grep -r 'world' ~/project/
```
### 输出中显示行号
```
grep -n 'hello' aa.txt
```
### 统计匹配到的行的数量
```
grep -c 'hello' aa.txt
```
### 在多个文件中检索某个字符串
```
grep "hello" filename1 filename2 filename3
```
### 检索时需要忽略大小写问题
```
grep -i  "hello" filename1
```

### 从文件内容查找不匹配指定字符串的行
```
grep -v  "hello" filename1
```
### grep设置颜色
```
grep --color "test" test.json
```