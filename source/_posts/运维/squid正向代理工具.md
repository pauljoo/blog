---
title: squid正向代理工具
date: 2021-04-10 10:56:57
categories:
- 运维
tags:
---

# 安装
```shell
yum install -y squid httpd
```
# 密码

## 创建密码：(设置为8位密码)
```shell
htpasswd -c -d /etc/squid/passwd <username>
```

## 修改配置文件添加密码验证：
在# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS下添加
```
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic credentialsttl 2 hours
acl ncsa_users proxy_auth REQUIRED
http_access allow ncsa_users
```

# 命令
```shell
#启动
squid start
#关闭
squid -k interrupt
```