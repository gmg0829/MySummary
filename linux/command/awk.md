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
