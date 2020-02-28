---
title: 分布式任务-Elastic-Job
date: 2018-12-10 16:55:58
categories:
- 分布式
tags:
---

# Elastic-Job-Lite

Elastic-Job-Lite定位为轻量级无中心化解决方案，使用jar包的形式提供最轻量级的分布式任务的协调服务，外部依赖仅Zookeeper。



### 主节点选举

|节点|节点类型|节点作用|
|-|-|-|
|/${namespace}/${jobName}/leader/election/latch|持久|用于选举的锁|
|/${namespace}/${jobName}/leader/election/instance|临时|保存主节点地址|
|/${namespace}/${jobName}/leader/sharding/necessary|持久|判断是否需要重新分片|
|/${namespace}/${jobName}/leader/sharding/processing|临时|标记主节点正在sharding 的标志|
|/${namespace}/${jobName}/sharing/${shardingItem}/instance|永久|保存拿到shardingItem分片的作业实例|
