## ZGC
与CMS中的ParNew和G1类似，ZGC也采用标记-复制算法，不过ZGC对该算法做了重大改进：ZGC在标记、转移和重定位阶段几乎都是并发的，这是ZGC实现停顿时间小于10ms目标的最关键原因。

ZGC通过着色指针和读屏障技术，解决了转移过程中准确访问对象的问题，实现了并发转移。ZGC停顿时间与GC Roots成正比，GC Roots数量越大，停顿时间越久。

https://mp.weixin.qq.com/s/ag5u2EPObx7bZr7hkcrOTg

