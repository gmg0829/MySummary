## sed

编辑命令

使用sed删除输出结果某些行
```
nl zcwyou.txt | sed '3,7d'
```
删除带有123的行
```
sed '/123/d' zcwyou.txt
```
删除第二行
```
sed '2d' zcwyou.txt
```
删除第2行到最后一行
```
sed '2,$d' zcwyou.txt
```
在第二行后面加上字符串hello jack
```
nl ~/zcwyou.txt | sed '2a hello jack'
```
在第二行前面加上字符串hello jack
```
nl ~/zcwyou.txt | sed '2i hello jack' 
```
文本中的9001替换为9002
```
sed "s/9001/9002/g" sshforwarding.service
```
替换后保存为新文件
```
sed "s/9001/9002/g" sshforwarding.service > sshforwarding9002.service
```
