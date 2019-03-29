---
title: CentOS-内核升级
date: 2018-10-01 11:28:00
categories:
- 操作系统
tags:
- CentOS
---

EPEL的全称叫 Extra Packages for Enterprise Linux 。EPEL是由 Fedora 社区打造，为 RHEL 及衍生发行版如 CentOS、Scientific Linux 等提供高质量软件包的项目。装上了 EPEL之后，就相当于添加了一个第三方源。

```shell
# 查看当前内核版本
uname -r
cat /etc/redhat-release

# 安装内核包
yum install kernel-lt-4.4.147-1.el7.elrepo.x86_64.rpm
yum install kernel-lt-devel-4.4.147-1.el7.elrepo.x86_64.rpm

# 查看启动项
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

# 设置启动项
grub2-set-default 0

# 检查启动项是否设置成功
grub2-editenv list
```

## 编译内核

https://wiki.centos.org/HowTos/Custom_Kernel

```shell
yum install -y rpm-build rpmdevtools

yum groupinstall -y "Development Tools"
yum install -y asciidoc bc m4 net-tools openssl-devel xmlto audit-libs-devel binutils-devel bison elfutils-devel java-1.8.0-openjdk-devel newt-devel numactl-devel perl python-devel slang-devel	xz-devel	zlib-devel ncurses-devel pciutils pciutils-devel
# 生成目录
rpmdev-setuptree

cp kernel-lt-4.4.147-1.el7.elrepo.nosrc.rpm rpmbuild/SRPMS/
cp linux-4.4.147.tar.xz rpmbuild/SOURCES/

rpm -ivh ~/rpmbuild/SRPMS/kernel-lt-4.4.147-1.el7.elrepo.nosrc.rpm
# 使用rpmbuild就可以一键编出你的内核到 ~/rpmbuild/RPMS/ 目录中了
rpmbuild -bb --with baseonly --with firmware ~/rpmbuild/SPECS/kernel-lt-4.4.spec

#编译过程会用到大量随机种子，遇到 waiting for lock on `./random_seed'... 提示时请执行
rngd -r /dev/urandom
```