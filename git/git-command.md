## git 初始化提交项目
git init
git remote add origin https://github.com/gmg0829/cheatSheet.git
git add .
git commit -m "init"
git push origin master 


## 简单的代码提交流程

git status 查看工作区代码相对于暂存区的差别
git add . 将当前目录下修改的所有代码从工作区添加到暂存区 . 代表当前目录
git commit -m ‘注释’ 将缓存区内容添加到本地仓库
git pull origin master先将远程仓库master中的信息同步到本地仓库master中
git push origin master 将本地版本库推送到远程服务器，
origin是远程主机，master表示是远程服务器上的master分支，分支名是可以修改的

### git add
1、git add .
不加参数默认为将修改操作的文件和未跟踪新添加的文件添加到git系统的暂存区，注意不包括删除
2、git add -u .
-u 表示将已跟踪文件中的修改和删除的文件添加到暂存区，不包括新增加的文件，注意这些被删除的文件被加入到暂存区再被提交并推送到服务器的版本库之后这个文件就会从git系统中消失了。
3、git add -A .
-A 表示将所有的已跟踪的文件的修改与删除和新增的未跟踪的文件都添加到暂存区。

### git commit 
git commit 主要是将暂存区里的改动给提交到本地的版本库。每次使用git commit 命令我们都会在本地版本库生成一个40位的哈希值，这个哈希值也叫commit-id。

1、git commit -m ‘message’
-m 参数表示可以直接输入后面的“message”，如果不加 -m参数，那么是不能直接输入
### git push
1、git push origin master
如果远程分支被省略，如上则表示将本地分支推送到与之存在追踪关系的远程分支（通常两者同名），如果该远程分支不存在，则会被新建


## git常用命令
### 比较当前文件的修改
$ git diff <file>
### 查看历史提交记录
git log

$ git log --pretty=oneline

### 回退版本
$  git reset --hard + commit id 

Git在内部有个指向当前版本的HEAD指针，当你回退版本的时候，Git仅仅是把HEAD从指向回退的版本，然后顺便刷新工作区文件；

### 查看操作的历史命令记录
$ git reflog

### Git分支管理
- 创建分支
$  git branch branch1
- 切换到branch1分支：
$ git checkout branch1
- 创建并切换到branch1分支
$ git checkout -b branch1
- 查看分支：
$ git branch
- 合并branch1分支到master：
$ git merge branch1
$ git merge --no-ff -m "merge" gmg
- 删除分支：
$ git branch -d branch1

### 暂存

$ git stash
- 查看已经保存的工作现场列表：
$ git stash list
- 恢复工作现场(恢复并从stash list删除)：
$ git stash pop



参考： https://juejin.im/post/5a4de5d8f265da432c2444b9#heading-19












