 
 ```
 bin/logstash -f logstash.conf
 ```
 
export JAVA_HOME=/usr/local/elasticsearch-7.2.0/jdk
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH