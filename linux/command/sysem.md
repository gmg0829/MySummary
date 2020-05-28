## uname
- uname  -a
- uname -o 操作系统名称
- uname -r  内核版本

## du 
- du -a 
- du -sh /usr/local  显示指定目录大小
- du -h  --max-depth=1  /usr/local 指定层次
- du -h  --max-depth=1  /usr/local --exclude=/usr/local/share

## watch
- watch –n 3 ls  每三秒执行一次
## df
df -h 磁盘使用情况

## uptime
显示时间，运行时长，负载

## free
- free -m
- free -h -s 10 定时刷新
## mpstat
- mpstat -P ALL

## iostat
- iostat -d 
- iostat -d -k
- iostat -d -m 以mb显示
- iostat -d -x -k 显示拓展信息

