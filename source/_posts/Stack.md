---
title: Stack
date: 2018-10-14 12:31:55
categories:
- 数据结构
tags:
---

栈是限制插入和删除只能在一个位置上进行的表，该位置是表的末端，叫做栈的顶。

栈又叫做LIFO(后进先出表)，由于栈是一个表，因此任何实现表的方法都能实现栈。

## 栈的链表实现  
栈的第一种实现方法是使用单链表。通过在表的顶端插入来实现push，通过删除表顶端元素实现pop。top操作只是考察表顶端元素并返回它的值。

## 栈的数组实现  
与每个栈相关联的操作是theArray和topOfStack，对于空栈它是-1。为将某个元素x推入栈，我们使topOfStack增1然后置theArray[topOfStack] = x。为了弹出栈元素，我们置返回值为theArray[topOfStack]然后使topOfStack减1。