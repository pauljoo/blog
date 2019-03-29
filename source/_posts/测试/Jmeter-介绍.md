---
title: Jmeter-介绍
date: 2018-11-06 12:46:06
categories:
- 测试
tags:
---

准备JMeter

安装插件

部署Master Slave

./jmeter.sh -n -t Ademo_cp.jmx -l jtl.jtl -j log.log -R B的IP

jmeter -n -t script.jmx -l jtl.jtl -R 127.0.0.1

slave启动命令：./jmeter-server -Djava.rmi.server.hostname=B的IP

master启动命令：

server:

jmeter-server



收集机器性能


Servers Performance Monitoring