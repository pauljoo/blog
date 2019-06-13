---
title: HotSpot实战-2启动
date: 2018-11-15 00:02:00
categories:
- Java
tags:
- HotSpot实战
---

## 启动

Hotspot提供了两种Launcher类型，分别是通用启动器(java)和调试版启动器(gamma)。

### 通用启动器

```shell
java [ option ] class [ argument ... ]
```

> 入口：jdk/src/share/bin/main.c

### 调试版启动器

> 入口：hostspor/src/share/tools/luncher/java.c

## 虚拟机生命周期

{% plantuml %}
Title: 虚拟机生命周期
Launcher->Launcher: main()
Launcher->线程JavaMain: JavaMain()
线程JavaMain->Launcher: IntializeJVM()
Launcher->JNI: JNI_CreateJavaVM()
JNI->Threads: create_vm()
Threads->Threads: add()
Threads->VMThread: create()
Threads->Init: vm_init_globals()
Threads->Init: init_globals()
Launcher->Launcher: LoadClass()
Launcher->Launcher: jni_CallStaticVoidMethod()
Launcher->Launcher: jni_DetachCurrentThread()
Launcher->Launcher: jni_DestroyJavaVM()
{% endplantuml %}
