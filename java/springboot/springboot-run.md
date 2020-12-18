```
export JAVA_HOME=/usr/local/jdk1.7.0_79
export JAVA_BIN=$JAVA_HOME/bin
export PATH=$PATH:$JAVA_BIN
export CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


nohup java -Xms500m -Xmx500m -Xmn250m -Xss256k -server -XX:+HeapDumpOnOutOfMemoryError -jar test-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev >log.file 2>&1  &

```

```
java -jar demo-0.0.1-SNAPSHOT.jar --spring.config.location=./config/application-dev.properties
```

mvn package -Dmaven.test.skip=true  

## 启动
start.sh
```
nohup java -jar xxxx-1.0.0-SNAPSHOT.jar &
echo $! > xxxx.pid
```
## 停止
shutdown.sh
```
kill -9 $(cat xxxx.pid)
rm -f xxxx.pid
```

```
java -jar -Dloader.path=lib  xxxApp.jar
java -jar -Dloader.path=lib,templates,static  xxxApp.jar
```

##  assembly.xml 打包



https://segmentfault.com/a/1190000015451706

