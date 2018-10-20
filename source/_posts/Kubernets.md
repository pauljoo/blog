---
title: Kubernets
date: 2018-10-14 13:55:15
categories:
- Virtual
- Docker
tags:
---
##概念  
kubernetes，简称K8s，是用8代替8个字符"ubernete"而成的缩写。是一个开源的，用于管理云平台中多个主机上的容器化的应用，Kubernetes的目标是让部署容器化的应用简单并且高效(powerful),Kubernetes提供了应用部署，规划，更新，维护的一种机制。

### Master  
k8s里的Master指的是集群控制节点，每个k8s集群里需要有一个Master节点来负责整个集群的管理和控制，基本上k8s所有的控制命令都是发给它，它来负责具体的执行过程。
Master节点上运行着以下一组关键进程。
1. kube-apiserver  
提供了Http Rest接口的关键服务进程，是k8s里所有资源的增删改查等操作的唯一入口，也是集群控制的入口进程。

2. kube-controller-manager  
k8s里所有资源对象的自动化控制中心。

3. kube-scheduler  
负责资源调度(Pod调度)的进行。

4. etcd Server  
k8s里的所有资源对象的数据全部是保存在etcd中。

### Node  
除了Master, k8s集群中的其他机器被称为Node节点，在较早的版本中也被成为Minion。Node节点是k8s集群中的工作负载节点，每个Node都会被Master分配一些工作负载(Docker容器)，当某个Node宕机时，其上的工作负载会被Master自动转移到其他节点上去。
Node节点上运行着以下一组关键进程。
1. kubelet  
负责Pod对应的容器的创建、启停等任务，同时与Master节点密切协作，实现集群管理的基本功能。

2. kube-proxy  
实现K8s Service的通信与负载均衡机制的重要组件。

3. Docker Engine  
Docker引擎，负责本机的容器创建和管理工作。

默认情况下kubelet会向Master注册自己，并定时向Master节点汇报自身的情况。当某个Node超过指定的时间不上报信息时，会被Master判定为"失联"。

### Pod  
Pod是k8s的最重要也最基本的概念。每个Pod都有一个特殊的被称为"根容器"的Pause容器。Pause容器对应的镜像属于k8s平台的一部分，除了Pause容器，每个Pod还包含一个或多个紧密相关的用户业务容器。

## 安装 

### 下载
`wget https://github.com/kubernetes/kubernetes/releases/download/v1.10.9/kubernetes.tar.gz`