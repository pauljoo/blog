---
title: squid正向代理工具
date: 2021-04-10 10:56:57
categories:
- 运维
tags:
---

# 镜像构建
```shell
git clone https://github.com/pauljoo/obfsproxy.git
tar -zxvf obfsproxy-0.2.13.tar.gz
apt-get update
apt-get install -y python-twisted python-pyptlib python-crypto python-yaml
```

# 服务端
监听3394端口，转发到本地的3128端口
```shell
/data/obfsproxy-0.2.13/bin/obfsproxy --data-dir=/data/scramblesuit scramblesuit --password=$PASSWORD --dest=127.0.0.1:3128 server 0.0.0.0:3394
```

# 客户端
监听9999端口，转发到远程的3394端口
```shell
/data/obfsproxy-0.2.13/bin/obfsproxy --data-dir=/data/scramblesuit scramblesuit --password=$PASSWORD --dest=127.0.0.1:3394 client 0.0.0.0:9999
```