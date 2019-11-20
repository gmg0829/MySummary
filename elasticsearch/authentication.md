## 用户认证与鉴权
### 身份认证
- 设置nginx代理
- 安装免费的security插件
- X-Pack 的Basic版(从6.8&7.0开始免费使用)
#### 开启X-Pack认证与鉴权
```
#启动单节点
bin/elasticsearch -E node.name=node0 -E cluster.name=geektime -E path.data=node0_data -E http.port=9200 -E xpack.security.enabled=true

#运行密码设定的命令，设置ES内置用户及其初始密码。
bin/elasticsearch-setup-passwords interactive
```
####  kibana开启认证
```
# 修改 kibana.yml
elasticsearch.username: "kibana"
elasticsearch.password: "changeme"
```
kibana可以设置用户、角色、权限。

