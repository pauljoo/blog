---
title: MapReduce
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---
1  问题的出现

       多年来磁盘存储容量快速增加的同时，其访问速度-磁盘数据读取速度-却未能与时俱进。

       读取一个磁盘中所有的数据需要很长的时间，写甚至更慢。一个很简单的减少读取时间的办法是同时从多个磁盘上读取数据。试想，如果我们拥有100个磁盘，每个磁盘存储1%的数据，并行读取，那么不到两分钟就可以读取所有数据。

       MapReduce提出了一个编程模型，该模型将上述磁盘读写的问题进行抽象，并转换为对一个数据集(由键/值对组成)的计算
2  MapReduce

       MapReduce是一种可用于数据处理的编程模型。MapReduce程序本质上是并行运行的，因此可以将大规模的数据分析任务交给任何一个拥有足够多机器的运营商。MapReduce的优势在于处理大规模数据集。
2.1  map阶段和reduce阶段

       MapReduce任务过程被分为两个处理阶段：map阶段和reduce阶段。每个阶段都以键/值对作为输入和输出，并由程序员选择它们的类型。程序员还需具体定义两个函数:map函数和reduce函数。
2.2  找出最高气温

目标：根据原始数据找出每年的最高气温。

原始数据：包含了一年中每天的气温记录。

|名称|map|
|-|-|
|输入|原始数据|
|输出|(1950, 0)|
||(1950,22)|
||(1950,-11)|
||-1,949,111|
||(1949,78)|
|功能|从原始数据中提取出有用数据组成键/值对|

|名称|shuffle|
|-|-|
|输入|(1950, 0)|
||(1950, 22)|
||(1950, -11)|
||(1949, 111)|
||(1949, 78)|
|输出|(1949, [111,78])|
||(1950, [0, 22, -11])|

|名称|reduce|
|-|-|
|输入|(1949, [111, 78])|
||(1950, [0, 22, -11])|
|输出|(1949, 111)|
||(1950, 22)|
|功能|遍历整个列表找出最大值|
