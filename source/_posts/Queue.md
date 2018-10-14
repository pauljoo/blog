---
title: Queue
date: 2018-10-14 12:32:01
tags:
---

队列也是表，使用队列时插入在一端进行而删除在另一端进行。

## 队列的数组实现  
对于每一个队列数据结构，我们保留一个数组theArray以及位置front和back，它们代表队列的两端。我们还要记录实际存在于队列中的元素的个数currentSize。

为使一个元素x入队(即执行enqueue)，我们让currentSize和back增1，然后置theArray[back] = x。若使元素dequeue(出队)，我们置返回值为theArray[front]，且currentSize减1，然后使front增1。