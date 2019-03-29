---
title: Zookeeper-安装
date: 2018-11-16 20:04:09
categories:
- 中间件
tags:
- Zookeeper
---

# 环境

- CentOS Linux release 7.4.1708
- OpenJDK Runtime Environment (build 1.8.0_131-b12)
- zookeeper-3.4.8

# 配置

```shell
# begin 1

# zoo.cfg
dataDir=/root/zookeeper-3.4.8-1/data
clientPort=2081

server.0=10.0.2.15:2788:3788
server.1=10.0.2.15:2888:3888
server.2=10.0.2.15:2988:3988
# /root/zookeeper-3.4.8-1/data/myid
0
# end 1

# begin 2
# zoo.cfg
dataDir=/root/zookeeper-3.4.8-2/data
clientPort=2181

server.0=10.0.2.15:2788:3788
server.1=10.0.2.15:2888:3888
server.2=10.0.2.15:2988:3988
# /root/zookeeper-3.4.8-2/data/myid
1
# end 2

# begin 3
# zoo.cfg
dataDir=/root/zookeeper-3.4.8-3/data
clientPort=2281

server.0=10.0.2.15:2788:3788
server.1=10.0.2.15:2888:3888
server.2=10.0.2.15:2988:3988
# /root/zookeeper-3.4.8-3/data/myid
2
# end 3
```

# 启动

```shell
zkServer.sh start
zkServer.sh status

zkCli.sh
```