shell中每个进程都和三个系统文件相关联
- 标准输入stdin
- 标准输出stdout
- 标准错误stderr
三个系统文件的文件描述符分别为0，1和2。

所以这里2>&1的意思就是将标准错误也输出到标准输出当中。

标准输处和标准错误重定向到不同log文件中

sh mr_add_test.sh 1>log.log 2>log_err.log