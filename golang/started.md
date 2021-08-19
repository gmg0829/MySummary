## go语言

### 配置路径
- GOROOT 
    - go的安装路径
- GOPATH
    - go install/go get和 go的工具等会用到GOPATH环境变量
    - GOPATH是作为编译后二进制的存放目的地和import包时的搜索路径 (其实也是你的工作目录, 你可以在src下创建你自己的go源文件, 然后开始工作)。

        1、GOPATH之下主要包含三个目录: bin、pkg、src
        
        2、bin目录主要存放可执行文件; 
        pkg目录存放编译好的库文件, 主要是*.a文件; src目录下主要存放go的源文件
### 包管理工具
gopm:
```
go get -v -u github.com/gpmgo/gopm
gopm  get github.com/go-sql-driver/mysql 
go  get github.com/jinzhu/gorm 
gopm  get github.com/gin-gonic/gin
```

#### go module 使用介绍
GO111MODULE=on启用模块支持，编译时会忽略GOPATH和vendor文件夹，只根据 go.mod下载依赖，将依赖下载至%GOPATH%/pkg/mod/ 目录下


go mod init <your module path>
go build
go list -m all
go mod download
go get -u  升级版本
go mod tiny 清除不需要的依赖
go mod vendor mod生成vendor目录
go mod graph 打印模块依赖图
go mod edit -require=golang.org/x/text 添加依赖项
go mod edit -droprequire=golang.org/x/text 移除依赖项

## 常用包
https://github.com/jobbole/awesome-go-cn

https://golang.org/pkg/

