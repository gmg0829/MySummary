# 脚本
#!/bin/bash
# crontab
echo "------------------------------"


# 配置
crontab -e 
*/1 * * * * /root/data/test.sh >> /root/data/load.log 2>&1

crontab -l