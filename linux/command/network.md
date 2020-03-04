## Linux 网络命令

网络配置： ifconfig、 ip
连通性探测： ping、 traceroute、 telnet、 mtr
网络连接： netstat、 ss、 nc、 lsof
流量统计： ifstat、 sar、 iftop
交换与路由： arp、 arping、 vconfig、 route
防火墙： iptables、 ipset
域名： host、 nslookup、 dig、 whois
抓包： tcpdump
虚拟设备： tunctl、 brctl、 ovs


### netstat
```
netstat -i 显示网络接口信息
netstat -s 显示所有网络协议栈信息
netstat -r 显示路由表信息
netstat -at 列出所有 TCP 端口
netstat -au 列出所有 UDP 端口
netstat -lt 列出所有监听 TCP 端口的 socket
netstat -lu 列出所有监听 UDP 端口的 socket
netstat -lx 列出所有监听 UNIX 端口的 socket
netstat -ap | grep ssh 找出程序运行的端口
netstat -an | grep ':80' 找出运行在指定端口的进程
```
#### 解决端口占用
lsof -i:{端口号}
或
netstat -tunlp|grep {port}

kill -9 {PID}

#### 对外开放端口

telnet ip 端口号
more /etc/sysconfig/iptables
vi /etc/sysconfig/iptables
-A INPUT -p tcp -m tcp --dport 8889 -j ACCEPT
/etc/init.d/iptables restart 




