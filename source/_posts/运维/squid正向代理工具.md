---
title: obfsproxy流量混淆工具
date: 2021-04-10 10:56:57
categories:
- 运维
tags:
---

https://github.com/pauljoo/obfsproxy.git
# 镜像构建
```shell
docker pull python:3.8.2
docker run -d --net=host python:3.8.2 /bin/bash -lc "tail -f /dev/null"
git clone https://github.com/dounine/obfsproxy.git
tar -zxvf obfsproxy-0.2.13.tar.gz
apt-get update
apt-get install -y python-twisted python-pyptlib python-crypto python-yaml
```

# 服务端
监听3394端口，转发到本地的2294端口
```shell
./bin/obfsproxy obfs3 --dest=127.0.0.1:2294 server 0.0.0.0:3394
```

# 客户端
监听9999端口，转发到远程的3394端口
```shell
./bin/obfsproxy obfs3 --dest=REMOTE:3394 client 0.0.0.0:9999
```