## 进程

-  pstree mysql
-  pgrep pid

pidstat -t -p pid 1 5

select  PROCESSLIST_ID from performance_schema.threads where THREAD_OS_ID =;
select  * from information_schema.processlist where ID =PROCESSLIST_ID;

https://blog.csdn.net/dtjiawenwang88/article/details/74906954

