---
title: Hotspot本地开发环境搭建
date: 2020-11-16 20:04:09
categories:
- Java
tags:
---

yum -y install gdb-gdbserver openssl openssh-server

./configure --with-user-release-suffix= --with-target-bits=64 --with-boot-jdk= --with-debug-level=slowdebug --enable-debug-symbols
make ZIP_DEBUGINFO_FILES=0