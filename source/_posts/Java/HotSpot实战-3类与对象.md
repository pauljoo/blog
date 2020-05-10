---
title: HotSpot实战-3类与对象
date: 2018-11-15 00:03:00
categories:
- Java
tags:
- HotSpot实战
---

## 源码路径
> hotspot/src/share/vm/oops

## OOP-Klass
1. OOP(ordinary object pointer): 普通对象指针，用来描述对象实例信息
2. Klass: Java类的C++对等体，用来描述Java类。

## 模块
### OOP
|模块|模块说明|
|-|-|
|oop|定义了OOPS共同基类|

### Klass
|模块|模块说明|
|-|-|
|Klass|用来描述语言层的类型|
|instanceKlass|在虚拟机层面描述一个Java类|