# git配置多个ssh公钥信息


以windows 10配置，进入用户目录的.ssh目录,打开git bash命令行。

## 生成rsa key

###  创建github的rsa key，名字为github
```
ssh-keygen -t rsa -C "你的git帐号邮箱" -f ~/.ssh/github
```
### 公司搭建的rsa key，名字为gitlab，目录~/.ssh/
```
ssh-keygen -t rsa -C "你公司的gitlab帐号邮箱" -f ~/.ssh/gitlab
```
## 在.ssh目录下创建config文件

```
Host github.com
 HostName github.com
 User git
 IdentityFile C:/Users/gmg/.ssh/id_rsa

Host company
 HostName gitlab.xx.com
 User git
 IdentityFile C:/Users/gmg/.ssh/gitlab
```

## github、gitlab配置

添加SSH公钥(*.pub)到官方的github、公司搭建的gitlab中。

## 测试
```
ssh -T git@github.com

ssh -T git@gitlab.xx.com
```