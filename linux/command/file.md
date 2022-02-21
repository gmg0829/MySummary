## wc
- wc -c /etc/file.txt 字节数
- wc -l /etc/file.txt 行数
- wc -w /etc/file.txt 单词数
## iconv
转换编码
- iconv -f  gb2312 -t utf-8 gb2312.txt

## 查看文件编码
在Vim中可以直接查看文件编码
:set fileencoding
## diff和vimdiff
对比文件

## tr
替换或删除字符
- tr 'abc' 'xyz' < oldboy.txt ##abc 替换为 xyz
- tr '[a-z]' '[A-Z]' < oldboy.txt 小写转大写
- tr -d 'oldboy'<oldboy.txt 删除字符
- tr -d '\n\t'<oldboy.txt

## split
- split -l 10 intab new_ 每10行分割一次
- split -l 10 -d intab new_  每10行分割一次，使用数字后缀
- split -b 500k -d intab new_  按大小分割
## sort
- sort -n aa.txt 按照数字大小排序
- sort -nr aa.txt 按照数字大小降序排序

## join
- join a.txt b.txt

## uniq
-  uniq a.txt
-  uniq -c a.txt 显示行出现的次数

## rename
rename from to file 

- rename .jpg .png *.jpg
# 把文件名中的AA替换成aa
rename "s/AA/aa/" * 
# 把.html 后缀的改成 .php后缀
rename "s//.html//.php/" * 
# 把所有的文件名都以txt结尾
rename "s/$//.txt/" *
# 把所有以.txt结尾的文件名的.txt删掉
rename "s//.txt//" *

# gz
gzip a.txt
gunzip a.gz -d 解压位置










