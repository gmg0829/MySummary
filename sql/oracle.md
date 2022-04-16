sys；   //系统管理员，拥有最高权限
system；//本地管理员，次高权限
scott； //普通用户，密码默认为tiger,默认未解锁


sqlplus / as sysdba；  //登陆sys帐户
sqlplus sys as sysdba；//同上
sqlplus scott/tiger；  //登陆普通用户scott


create user zhangsan identified by zhangsan default tablespace users quota 10M on users

grant create session, create table, create view to zhangsan

grant 权限列表，.. to username [with admin option 同时获得权限分配权];
revoke 权限列表，.. from usernam;    

grant create session to zhangsan;//授予zhangsan用户创建session的权限，即登陆权限
grant unlimited tablespace to zhangsan;//授予zhangsan用户使用表空间的权限
grant create table to zhangsan;//授予创建表的权限
grante drop table to zhangsan;//授予删除表的权限
grant insert table to zhangsan;//插入表的权限
grant update table to zhangsan;//修改表的权限
grant all to public;//这条比较重要，授予所有权限(all)给所有用户(public)

exp iafp/iafp_sdm@10.224.32.12:1521/ora12c owner=iafp file=/iafp/gmg/sdm.dmp
imp iafp/iafp_sdm@10.224.32.12:1521/ora12c owner=iafp file=/iafp/gmg/sdm.dmp full=y ignore=y

https://blog.csdn.net/weixin_31091881/article/details/116313742

