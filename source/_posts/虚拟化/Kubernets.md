---
title: Kubernets
date: 2018-10-14 13:55:15
categories:
- 虚拟化
tags:
- Docker
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

### kubernetes
```shell
systemctl stop firewalld
yum install -y docker etcd kubernetes
vi /etc/sysconfig/docker
OPTIONS='--selinux-enabled=false --log-driver=journald --signature-verification=false'
systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy
```

### minikube
```shell
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/


minikube start --vm-driver=none --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers' --apiserver-ips=['192.168.0.1'] --service-cluster-ip-range=192.168.0.0/16
```
## 例子
定义RC文件
定义SVC文件
### mysql
```
kubectl create -f mysql-rc.yaml
kubectl create -f mysql-svc.yaml
```
### myweb
```
kubectl create -f myweb-rc.yaml
kubectl get rc
kubectl get pod
kubectl create -f myweb-svc.yaml
kubectl get svc
```
## FAQ

### unable to create pods: No API token found for service account "default"
```
vi /etc/kubernetes/apiserver 
KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"
# 去除SecurityContextDeny,ServiceAccount
# 重启
systemctl restart kube-apiserver
```

### No such image: registry.access.redhat.com/rhel7/pod-infrastructure:latest"
```
docker search pod-infrastructure
docker pull docker.io/tianyebj/pod-infrastructure
docker tag docker.io/tianyebj/pod-infrastructure 10.0.2.15:5000/pod-infrastructure
docker push 10.0.2.15:5000/pod-infrastructure
# 配置基础镜像
vi /etc/kubernetes/kubelet 
KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=10.0.2.11:5000/pod-infrastructure:latest"

systemctl restart kube-apiserver
systemctl restart kube-controller-manager
systemctl restart kube-scheduler
systemctl restart kubelet
systemctl restart kube-proxy
```

### "cgroupfs" is different from docker cgroup driver: "systemd"
```shell
vim /etc/docker/daemon.json
"exec-opts": ["native.cgroupdriver=cgroupfs"]
# 或者
vi /usr/lib/systemd/system/docker.service
```

### Error loading config file "/var/lib/minikube/kubeconfig": open /var/lib/minikube/kubeconfig: permission denied
```shell
vim /etc/selinux/config
SELINUX=disabled
```

### Failed to get system container stats for "/system.slice/kubelet.service"
```shell
/etc/systemd/system/kubelet.service.d/10-kubeadm.conf
--runtime-cgroups=/systemd/system.slice --kubelet-cgroups=/systemd/system.slice
systemctl daemon-reload
systemctl restart kubelet
```

### Failed to list *v1.Endpoints: Get https://10.96.0.1:443/api/v1/endpoints?limit=500&resourceVersion=0:
当您使用kubeadm init时，请指定pod-network-cidr。确保主机/主网络的IP不在您引用的子网中。
即如果您的网络运行在192.168.*.*使用10.0.0.0/16
如果您的网络是10.0.*.*使用192.168.0.0/16
```shell
--pod-network-cidr=192.168.0.0/16
# minikube
--service-cluster-ip-range=192.168.0.0/16

# 增加路由规则minikube ip查询出10.0.2.15
ip route add 192.168.0.0/16 via 10.0.2.15
```