https://zhuanlan.zhihu.com/p/81941373

https://tech.meituan.com/2020/10/22/java-jit-practice-in-meituan.html

JVM在执行时，首先会逐条读取IR的指令来执行，这个过程就是解释执行的过程。当某一方法调用次数达到即时编译定义的阈值时，就会触发即时编译，这时即时编译器会将IR进行优化，并生成这个方法的机器码，后面再调用这个方法，就会直接调用机器码执行，这个就是编译执行的过程。

## 即时编译器触发 
即时编译器触发的根据有两个方面：
- 方法的调用次数
- 循环回边的执行次数
JVM在调用一个方法时，会在计数器上+1，如果方法里面有循环体，每次循环，计数器也会+1。

CodeCache是热点代码的暂存区，经过即时编译器编译的代码会放在这里，它存在于堆外内存。


在Java8中默认开启了分层编译，在Java8中，无论是开启还是关闭了分层编译，-cilent和-server参数都是无效的了。当关闭分层编译的情况下，JVM会直接使用C2。



