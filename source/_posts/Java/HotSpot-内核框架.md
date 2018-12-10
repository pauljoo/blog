---
title: HotSpot-内核框架
date: 2018-11-16 20:04:09
categories:
- Java
tags:
---
## 启动

Hotspot提供了两种Launcher类型，分别是通用启动器(java)和调试版启动器(gamma)。

## Hotspot源码目录结构概览

|目录||||用途|
|-|-|-|-|-|
|agent||||Serviceability Agent(可维护性代理)|
|make||||编译hotspot的makefile文件|
|src||||主体源代码|
||cpu|||依赖具体处理器架构的代码(ppc,sparc,x86,zero)|
||os|||依赖操作系统的代码(bsd,linux,posix,solaris,windows)|
||os_cpu|||同时依赖操作系统和处理器的代码|
||share|||操作系统和处理器无关的代码(vm,tools)|
|||vm||实现虚拟机各项功能|
||||adlc|平台描述文件|
||||asm|汇编器|
||||c1|C1编译器,client编译器|
||||ci|动态编译器|
||||classfile|class文件解析和类的链接等|
||||code|机器码生成|
||||compiler|调用动态编译器|
||||gc_implementation|gc实现|
||||gc_interface|gc接口|
||||interpreter|解释器|
||||libadt|抽象数据结构|
||||memory|内存管理|
||||oops|jvm内部对象表示|
||||opto|C2编译器,server编译器|
||||precompiled||
||||prims|hotspot对外接口|
||||runtime|运行时|
||||services|jmx接口|
||||shark|基于LLVM实现的即时编译器|
||||trace||
||||utilizes|内部工具类和公共函数|
|||tools||独立的虚拟机工具程序|
|test||||测试用例|

### prims

prims模块定义了外部接口，允许外部程序访问内部状态信息。

1. jni模块

定义了jni_为前缀命名的函数，提供java运行时接口，允许外部程序调用由C/C++实现的库函数。

2. jvm模块

定义了jvm_为前缀命名的函数，作为标准jni接口的补充，在头文件jvm.h中声明。1.访问本地库的API，2.字节码验证和class文件格式验证,3.java io和网络API。

3. jvmti模块

定义了jvmti_为前缀命名的函数，允许程序员创建代理以监视和控制java应用程序。

4. perf模块

定义了perf_为前缀命名的函数，以监控虚拟机内部的perf data计数器。

5. services模块

主要包含9个主要子模块(management,memory service,thread service, runtime service, memory manager, heap dumper, classloading service, memory pool,attach listener)。

- management

提供jmx底层实现的基础
- memory service

提供jvm内存管理服务。如堆的分配和内存池的管理等。

- thread service

- runtime service

提供java运行时的性能监控和管理服务，如applicationTime、jvmCapabilities。

- memory manager

内存管理器。一个内存管理器负责管理一个或多个内存池。垃圾收集器也是一种内存管理器，负责回收不可达对象的内存空间。

- heap dumper

提供堆转储功能。

- classloading service

提供类加载模块的性能监控和管理服务。

- memory pool

内存池管理模块。内存池表示由jvm管理的内存区域。

- attach listener

jvm系统初始化时启动名为"Attach Listener"的守护线程。为客户端的jvm监控工具提供连接(attach)服务.

6. runtime

runtime是运行时模块，为其他系统组件提供运行时支持,如线程、安全点、PerfData、Stub例程、反射、VMOperation以及互斥锁等组件。