---
title: HotSpot实战-1内核框架
date: 2018-11-15 00:01:00
categories:
- Java
tags:
- HotSpot实战
---

## 编译

### 搭建环境

### 源代码下载

### Hotspot源码目录结构概览

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

### Prims

prims模块定义了外部接口，允许外部程序访问内部状态信息。

比如，jni模块，jvm模块，jvmti模块，perf模块。

### Services

services模块主要包含9个主要子模块(management,memory service,thread service, runtime service, memory manager, heap dumper, classloading service, memory pool,attach listener)。

### Runtime

runtime是运行时模块，为其他系统组件提供运行时支持,如线程、安全点、PerfData、Stub例程、反射、VMOperation以及互斥锁等组件。
