## kubectl

在管理工具界面使用kubectl语法运行如下命令：
```
kubectl [command] [TYPE] [NAME] [flags]
```
下表包括了所有kubectl操作简短描述和通用语法：
Operation|Syntax|Description
---|:--:|---:
annotate|kubectl annotate|为一个或多个资源添加注释
api-versions|kubectl api-versions|列出支持的API版本
apply|kubectl apply -f|对文件或stdin的资源进行配置更改。
attach|kubectl attach POD -c CONTAINER |连接到一个运行的容器，既可以查看output stream，也可以与容器(stdin)进行交互。
autoscale|kubectl autoscale|自动扩容/缩容由replication controller管理的一组pod。
cluster-info|kubectl cluster-info|显示有关集群中master和services的终端信息。
config|kubectl config |修改kubeconfig文件。有关详细信息，请参阅各个子命令。
create|kubectl create -f|从file或stdin创建一个或多个资源。
delete|kubectl delete|从file，stdin或指定label 选择器，names，resource选择器或resources中删除resources。
describe|kubectl describe|显示一个或多个resources的详细状态。
edit|kubectl edit|使用默认编辑器编辑和更新服务器上一个或多个定义的资源。
exec|kubectl exec POD|对pod中的容器执行命令。
explain|kubectl explain|获取各种资源的文档。例如pod，node，services等
expose|kubectl expose |将 replication controller，service或pod作为一个新的Kubernetes service显示。
get|kubectl get|列出一个或多个资源。
label|kubectl label|添加或更新一个或多个资源的flags。
logs|kubectl logs POD|在pod中打印容器的日志。
proxy|kubectl proxy|在Kubernetes API服务器运行代理。
run|kubectl run |在集群上运行指定的镜像。
scale|kubectl scale|更新指定replication controller的大小。
version|kubectl version|显示客户端和服务器上运行的Kubernetes版本。


## kubectl Cheat Sheet

创建对象

Kubernetes 的清单文件可以使用 json 或 yaml 格式定义。可以以 .yaml、.yml、或者 .json 为扩展名。

```
$ kubectl create -f ./my-manifest.yaml           # 创建资源
$ kubectl create -f ./my1.yaml -f ./my2.yaml     # 使用多个文件创建资源
$ kubectl create -f ./dir                        # 使用目录下的所有清单文件来创建资源
$ kubectl create -f https://git.io/vPieo         # 使用 url 来创建资源
$ kubectl run nginx --image=nginx                # 启动一个 nginx 实例
$ kubectl explain pods,svc                       # 获取 pod 和 svc 的文档
```

显示和查找资源
```
 $kubectl get services                          # 列出所有 namespace 中的所有 service
$ kubectl get pods --all-namespaces             # 列出所有 namespace 中的所有 pod
$ kubectl get pods -o wide                      # 列出所有 pod 并显示详细信息
$ kubectl get deployment my-dep                 # 列出指定 deployment
$ kubectl get pods --include-uninitialized      # 列出该 namespace 中的所有 pod 包括未初始化的

# 使用详细输出来描述命令
$ kubectl describe nodes my-node
$ kubectl describe pods my-pod
```

更新资源
```
$ kubectl rolling-update frontend-v1 -f frontend-v2.json           # 滚动更新 pod frontend-v1
$ kubectl rolling-update frontend-v1 frontend-v2 --image=image:v2  # 更新资源名称并更新镜像
$ kubectl rolling-update frontend --image=image:v2                 # 更新 frontend pod 中的镜像
$ kubectl rolling-update frontend-v1 frontend-v2 --rollback        # 退出已存在的进行中的滚动更新
$ cat pod.json | kubectl replace -f -                              # 基于 stdin 输入的 JSON 替换 pod

# 强制替换，删除后重新创建资源。会导致服务中断。
$ kubectl replace --force -f ./pod.json

# 为 nginx RC 创建服务，启用本地 80 端口连接到容器上的 8000 端口
$ kubectl expose rc nginx --port=80 --target-port=8000
$ kubectl label pods my-pod new-label=awesome                      # 添加标签
$ kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # 添加注解
$ kubectl autoscale deployment foo --min=2 --max=10                # 自动扩展 deployment “foo”
```
Scale资源
```
$ kubectl scale --replicas=3 rs/foo                                 # Scale a replicaset named 'foo' to 3
$ kubectl scale --replicas=3 -f foo.yaml                            # Scale a resource specified in "foo.yaml" to 3
$ kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # If the deployment named mysql's current size is 2, scale mysql to 3
$ kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale multiple replication controllers
```
删除资源
```
$ kubectl delete -f ./pod.json                                              # 删除 pod.json 文件中定义的类型和名称的 pod
$ kubectl delete pod,service baz foo                                        # 删除名为“baz”的 pod 和名为“foo”的 service
$ kubectl delete pods,services -l name=myLabel                              # 删除具有 name=myLabel 标签的 pod 和 serivce
$ kubectl delete pods,services -l name=myLabel --include-uninitialized      # 删除具有 name=myLabel 标签的 pod 和 service，包括尚未初始化的
$ kubectl -n my-ns delete po,svc --all                                      # 删除 my-ns namespace 下的所有 pod 和 serivce，包括尚未初始化的
```
与运行中的 Pod 交互
```
$ kubectl logs my-pod                                 
# dump 输出 pod 的日志（stdout）
$ kubectl logs my-pod -c my-container                
# dump 输出 pod 中容器的日志（stdout，pod 中有多个容器的情况下使用）
$ kubectl logs -f my-pod                              
# 流式输出 pod 的日志（stdout）
$ kubectl logs -f my-pod -c my-container              
# 流式输出 pod 中容器的日志（stdout，pod 中有多个容器的情况下使用）
$ kubectl run -i --tty busybox --image=busybox -- sh  
# 交互式 shell 的方式运行 pod
$ kubectl attach my-pod -i                            
# 连接到运行中的容器
$ kubectl port-forward my-pod 5000:6000               
# 转发 pod 中的 6000 端口到本地的 5000 端口
$ kubectl exec my-pod -- ls /                         
# 在已存在的容器中执行命令（只有一个容器的情况下）
$ kubectl exec my-pod -c my-container -- ls /         
# 在已存在的容器中执行命令（pod 中有多个容器的情况下）
$ kubectl top pod POD_NAME --containers               
# 显示指定 pod 和容器的指标度量
```

与节点和集群交互
```
$ kubectl cluster-info                                            # 显示 master 和服务的地址
$ kubectl cluster-info dump                                       # 将当前集群状态输出到 stdout        
```

资源类型
资源类型|缩写别名|
---|:--:
clusters|
ingresses|ing
nodes|no
pods|po
replicationcontrollers|rc
serviceaccount|sa
services|svc
namespaces|ns
event|ev
endpoints|ep
deployments|deploy
configmaps|cm


### Kubernetes kubectl get 命令详解
列出所有运行的Pod信息。
```
kubectl get pods
```

列出Pod以及运行Pod节点信息。
```
kubectl get pods -o wide
```

列出指定NAME的 replication controller信息。
```
kubectl get replicationcontroller web
```
