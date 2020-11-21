---
title: C++标准程序库-通用工具
date: 2018-11-16 20:04:09
categories:
- CPP
tags:
---
## Pair和Tuple
Class pair可将两个value视为一个单元。
```c++
namespace std
{
	template <typename T1, typename T2>
	struct pair
	{
		T1 first;
		T2 second;
	};
}
```
不定数的值组
```c++
namespace std
{
	template <typename... Types>
	class tuple;
}
```

## Smart Pointer
自c++ 11起，c++标准库提供两大类型的smart pointer
1. shared_ptr(共享式指针)
多个smart pointer可以指向相同对象，该对象和其相关资源会在“最后一个reference被销毁”时被释放。
2. unique_ptr(独占式拥有)
保证同一时间内只有一个smart pointer可以指向该对象。

## 数值的极值
数值类型有着与平台相依的极值。
numeric_limits<>
|类型|最小长度|
|--|--|
|char|1 byte|
|short int|2 byte|
|int|2 byte|
|long int|4 byte|
|long long int|8 byte|
|float|4 byte|
|double|8 byte|
|long double|8 byte|

## Type Trait和Type Utility
type trait提供一种用来处理type属性的方法。可以用来检查类型的性质，类型的比较。

## 辅助函数
选择最小值、最大值、交换两值

## ratio
编译器分数运算

## Clock和Timer
处理日期和时间的程序库。