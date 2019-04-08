```
docker run  -v $PWD/myapp:/usr/src/myapp  -w /usr/src/myapp python:3.5 python helloworld.py
```

命令说明：
-v $PWD/myapp:/usr/src/myapp :将主机中当前目录下的myapp挂载到容器的/usr/src/myapp
-w /usr/src/myapp :指定容器的/usr/src/myapp目录为工作目录
python helloworld.py :使用容器的python命令来执行工作目录中的helloworld.py文件