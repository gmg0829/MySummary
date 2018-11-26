# k8s基本概念和术语

## Master
Master是集群的控制节点，每个K8s集群里需要有一个Master节点来负责整个集群的管理和控制。基本上k8s的所有控制命令都发给它，它来负责整个具体的执行过程。Master节点通常占据一个独立的服务器（高可用部署建议3台服务器）。

Master节点运行着以下一组关键过程：
- API Server：集群控制的入口进程。
- k8s Controller Manager：K8s里所有资源对象的自动化控制中心
- K8s Scheduler:负责资源调度的进程。
- etcd:所有资源对象的数据全部保存在etcd。

## Node

Node节点是K8s集群中的工作负载节点，当某个Node宕机时，其上的工作负载会被Master自动转移到其他节点上。

Node节点运行着以下一组关键过程：
- kubelet: 负责Pod对应容器的创建、启停等任务。
- kube-proxy: 实现k8s service的通信和负载均衡机制的重要组件。

## Pod
Pod是Kubernetes创建或部署的最小/最简单的基本单位，一个Pod代表集群上正在运行的一个进程。

一个Pod封装一个应用容器（也可以有多个容器），存储资源、一个独立的网络IP以及管理控制容器运行方式的策略选项。Pod代表部署的一个单位：Kubernetes中单个应用的实例，它可能由单个容器或多个容器共享组成的资源。

Pods提供两种共享资源：网络和存储。

网络

每个Pod被分配一个独立的IP地址，Pod中的每个容器共享网络命名空间，包括IP地址和网络端口。Pod内的容器可以使用localhost相互通信。当Pod中的容器与Pod 外部通信时，他们必须协调如何使用共享网络资源（如端口）。

存储

Pod可以指定一组共享存储volumes。Pod中的所有容器都可以访问共享volumes，允许这些容器共享数据。volumes 还用于Pod中的数据持久化，以防其中一个容器需要重新启动而丢失数据。

Pod、容器与Node的关系如下图所示:

![](https://raw.githubusercontent.com/gmg0829/Img/master/k8s/node-pod-container.png)

Pod生命周期：

Pod 的 status 定义在 PodStatus 对象中，其中有一个 phase 字段。

下面是 phase 可能的值：
   - 挂起（Pending）：Pod 已被 Kubernetes 系统接受，但有一个或者多个容器镜像尚未创建。等待时间包括调度 Pod 的时间和通过网络下载镜像的时间，这可能需要花点时间。
   - 运行中（Running）：该 Pod 已经绑定到了一个节点上，Pod 中所有的容器都已被创建。至少有一个容器正在运行，或者正处于启动或重启状态。
   - 成功（Succeeded）：Pod 中的所有容器都被成功终止，并且不会再重启。
   -  失败（Failed）：Pod 中的所有容器都已终止了，并且至少有一个容器是因为失败终止。也就是说，容器以非0状态退出或者被系统终止。
   - 未知（Unknown）：因为某些原因无法取得 Pod 的状态，通常是因为与 Pod 所在主机通信失败。
## Labels

Labels其实就一对 key/value ，其中key与value由用户自己指定。Label可以附加到各种资源对象上。例如Node、Pod、Service、RC等，一个资源对象可以定义任意数量的Label。

我们可以给指定的资源对象捆绑一个或多个不同的Label来实现多维度的资源分组管理功能，以便于灵活、方便地进行资源分配、调度、配置、部署等管理工作。一些常用的Label示例：
- 版本标签：“release”,"stable"...
- 环境标签: "dev","pro"...

## ReplicationController 

RC是K8s系统中的核心概念之一，简单来说，它其实定义了一个期望的场景。即声明某种Pod的副本数量在任意时刻都符合某个预期值。RC包括以下几个部分：
- Pod期待的副本数
- 用于筛选目标Pod的Label Selector。
- 当Pod的副本数量小于预期数量时，用于创建新的Pod模板（template）

当我们定义了一个RC并提交到了K8s集群以后，Master几点上的Controller Manager组件就得到通知，定时巡检系统中目前存活的目标Pod,并且确保目标Pod实例的数量刚好等于此RC的期望值。如果有过多的副本在运行，系统就会停掉一些Pod,否则系统就会再自动创建一些Pod。

## Deployment
Deployment是V1.2引入的新概念，引入的目的是为了更好地解决Pod的编排问题。
为此Deployment在内部使用了Replica Set来实现目的。Deployment相对于RC的一个最大升级是我们可以随时知道当前Pod部署的进度。

Deployment的使用场景：
- 创建一个Deployment对象来生成对应的Replica Set并完成Pod副本的创建过程。
- 检查Deployment的状态来看部署动作是否完成。
- 更新Deployment以创建新的Pod(比如镜像升级)
- 如果当前的Deployment不稳定，则回滚到早先的Deployment版本
- 拓展Deployment以应对高负载。
- 清理不在需要的旧版本ReplicaSets。

## Service

Kubernetes Pod 是有生命周期的，它们可以被创建，也可以被销毁，然而一旦被销毁生命就永远结束。如果有一组Pod组成一个集群来提供服务，那么如何来访问他们呢？

一个Service可以看成一组提供相同服务的Pod的对外访问接口。

Pod的Ip地址和Service的Cluster IP地址：

Pod的Ip地址是Docker Daemon根据docker0网桥的Ip地址段进行分配的，但Service的Cluster IP地址是k8s系统中的虚拟IP地址。Service的Cluster IP地址相对于Pod的IP地址来说相对稳定。

外部访问Service

由于Service对象在Cluster IP Range池中分配的IP地址只能在内部访问，所以其他Pod都可以无障碍地访问它。

K8s提供两种对外提供服务的Service的Type定义：Nodeport和LoadBalance

1)Nodeport
```
apiVersion: v1
kind: Service
metadata:
  labels:
    name: hello
  name: hello
spec:
  type: NodePort
  ports:
  - port: 8080
    nodePort: 30008
  selector:
    name: hello
  
```
假设有3个hello Pod运行在3个不同的Node上，客户端访问其中任意一个Node都可以访问到这个服务。

2)LoadBalance

```
kind: Service
apiVersion: v1
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
      nodePort: 30061
  clusterIP: 10.0.171.239
  loadBalancerIP: 78.11.24.19
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
      - ip: 146.148.47.155
```
status.loadBalancer.ingress.ip设置的146.148.47.155为云提供商提供的负载均衡器的IP地址，
## Volume 

默认情况下容器中的磁盘文件是非持久化的，对于运行在容器中的应用来说面临两个问题，第一：当容器挂掉kubelet将重启启动它时，文件将会丢失；第二：当Pod中同时运行多个容器，容器之间需要共享文件时。Kubernetes的Volume解决了这两个问题。

在Docker中也有一个docker Volume的概念 ，Docker的Volume只是磁盘中的一个目录，生命周期不受管理。Kubernetes Volume具有明确的生命周期 - 与pod相同。在容器重新启动时能可以保留数据，当然，当Pod被删除不存在时，Volume也将消失。注意，Kubernetes支持许多类型的Volume，一个Pod可以同时使用任意类型/数量的Volume。

Kubernetes支持Volume类型有：

- emptyDir
使用emptyDir，当Pod分配到Node上时，将会创建emptyDir，并且只要Node上的Pod一直运行，Volume就会一直存。当Pod（不管任何原因）从Node上被删除时，emptyDir也同时会删除，存储的数据也将永久删除。注：删除容器不影响emptyDir。

示例：
```
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: gcr.io/google_containers/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}
```

- hostPath
hostPath允许挂载Node上的文件系统到Pod里面去。如果Pod需要使用Node上的文件，可以使用hostPath。
示例:
```
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: gcr.io/google_containers/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /test-pd
      name: test-volume
  volumes:
  - name: test-volume
    hostPath:
      # directory location on host
      path: /data
```

## Namespace

Namespace是K8s系统中非常重要的概念，通过将系统内部的对象“分配”到不同Namespace。
K8s集群在启动后，会创建一个名为“default”的Namespace。

创建一个名为redis-master的Pod,放入到redis-namespace这个Namespace里。
示例：
```
apiVersion: v1
kind: Pod
metadata:
  name: redis-master
  namespace: redis-namespace
spec:
     containers:
      - name: master
        image: kubeguide/redis-master
        ports:
        - containerPort: 6379
```
