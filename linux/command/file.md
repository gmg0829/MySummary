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






