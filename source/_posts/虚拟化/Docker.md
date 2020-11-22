---
title: Docker
date: 2018-10-14 12:19:28
categories:
- 虚拟化
tags:
- Docker
---

## Docker安装

### 修改YUM源

1. 备份  
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

2. 下载对应版本repo文件  
wget http://mirrors.163.com/.help/CentOS7-Base-163.repo

3. 运行以下命令生成缓存  
yum clean all
yum makecache

4. 安装docker  
yum install docker

## Docker Registry搭建  
```
docker run -d -p 5000:5000 -v /data/registry:/var/lib/registry --restart=always --name registry registry:2
# 配置非安全访问的仓库IP:端口号
/etc/docker/daemon.json 
"insecure-registries":["10.0.2.15:5000"]

docker push 192.168.1.62:5000/xpanda/busybox
docker pull 192.168.1.62:5000/xpanda/busybox
```

## Docker 国内镜像
```
vi /etc/docker/daemon.json
{
    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
systemctl restart docker.service
```
## 常用Docker命令

```
docker search
docker ps
docker images
#删除镜像
docker rmi
#删除容器实例
docker rm
#下载镜像
docker pull quay.io/coreos/etcd:v3.2.16
#构建镜像
docker build -t xpanda/nginx:1.12.2 .
#后台运行
docker run -d -p 8080:8080 -p 443:443 --ip 10.20.0.1 -v /data/configs/nginx/conf.d:/etc/nginx/conf.d -v /data/configs/nginx/certs:/etc/nginx/certs xpanda/nginx:1.12.2
#进入容器
docker exec -it 5c61a04b14fc /bin/bash
#日志查看
docker logs -f --tail=100 6aa2172c8742
journalctl -u docker.service -n
```