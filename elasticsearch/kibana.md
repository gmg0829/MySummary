## kibana

### 汉化

kibana.yml文件中，增加i18n.locale: "zh-CN"，就支持中文显示了。

### 启动
nohup bin/kibana &

> 坑
https://dongkelun.com/2019/07/03/elkbConf/

### dev tools

### 插件

```
bin/kibana-plugin list
bin/kibana-plugin install
bin/kibana-plugin remove
```