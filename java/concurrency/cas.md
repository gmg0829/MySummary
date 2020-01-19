## Unsafe中的int类型的CAS操作方法：
```
 public final int getAndAddInt(Object var1, long var2, int var4) {
        int var5;
        do {
            //var5 通过 this.getIntVolatile(var1, var2)方法获取，是个 native 方法，其目的是获取 var1 在 var2 偏移量的值，其中 var1 就是 AtomicInteger， var2 是 valueOffset 值。
            var5 = this.getIntVolatile(var1, var2); 
        } while(!this.compareAndSwapInt(var1, var2, var5, var5 + var4));

        return var5;
    }
```
```
public final native boolean compareAndSwapInt(Object o, long offset,
                                                int expected,
                                                int x);
```                                                
参数o就是要进行cas操作的对象，offset参数是内存位置，expected参数就是期望的值，x参数是需要更新到的值。

## ABA问题？
- 并发1（上）：获取出数据的初始值是A，后续计划实施CAS乐观锁，期望数据仍是A的时候，修改才能成功
- 并发2：将数据修改成B
- 并发3：将数据修改回A
- 并发1（下）：CAS乐观锁，检测发现初始值还是A，进行数据修改

上述并发环境下，并发1在修改数据时，虽然还是A，但已经不是初始条件的A了，中间发生了A变B，B又变A的变化，此A已经非彼A，数据却成功修改，可能导致错误，这就是CAS引发的所谓的ABA问题。

## ABA问题的优化

常见实践：“版本号”的比对，一个数据一个版本，版本变化，即使值相同，也不应该修改成功。

AtomicStampedReference

## CAS的缺点：
CAS虽然很高效的解决了原子操作问题，但是CAS仍然存在三大问题。

- 循环时间长开销很大。
- 只能保证一个共享变量的原子操作。
- ABA问题

### 循环时间长开销很大：
我们可以看到getAndAddInt方法执行时，如果CAS失败，会一直进行尝试。如果CAS长时间一直不成功，可能会给CPU带来很大的开销。
### 只能保证一个共享变量的原子操作：
当对一个共享变量执行操作时，我们可以使用循环CAS的方式来保证原子操作，但是对多个共享变量操作时，循环CAS就无法保证操作的原子性，这个时候就可以用锁来保证原子性。

### 什么是ABA问题？ABA问题怎么解决？
如果内存地址V初次读取的值是A，并且在准备赋值的时候检查到它的值仍然为A，那我们就能说它的值没有被其他线程改变过了吗？

如果在这段期间它的值曾经被改成了B，后来又被改回为A，那CAS操作就会误认为它从来没有被改变过。这个漏洞称为CAS操作的“ABA”问题。Java并发包为了解决这个问题，提供了一个带有标记的原子引用类“AtomicStampedReference”，它可以通过控制变量值的版本来保证CAS的正确性。因此，在使用CAS前要考虑清楚“ABA”问题是否会影响程序并发的正确性，如果需要解决ABA问题，改用传统的互斥同步可能会比原子类更高效。

