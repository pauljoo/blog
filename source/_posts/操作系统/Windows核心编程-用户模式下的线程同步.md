---
title: Windows核心编程-用户模式下的线程同步
date: 2018-11-04 11:13:25
categories:
- 操作系统
tags:
---
###关键段
关键段(critical section)是一小段代码，它在执行之前需要独占对一些共享资源的访问权。
```c++
CRITICAL_SECTION g_cs;
int g_nSum = 0;
InitializeCriticalSection(&g_cs);

EnterCriticalSection(&g_cs);
g_nSum++;
LeaveCriticalSection(&g_cs);

DeleteCriticalSection(&g_cs);
```
###Slim读/写锁
SRWLock的目的和关键段相同，对同一资源进行保护，不让其他线程访问它。但是，与关键段不同的是，SRWLock允许我们区分那些（读取者线程）和（写入者线程）。让所有的读取者线程在同一时刻访问共享资源应该是可行的，这是因为仅仅读取资源的值并不存在破坏数据的风险。
```c++
SRWLOCK g_srwLock;
InitializeSRWLock(&g_srwLock);
//写入者线程调用
AcquireSRWLockExclusive(&g_srwLock);
ReleaseSRWLockExclusive(&g_srwLock);
//读取者线程调用
AcquireSRWLockShared(&g_srwLock);
ReleaseSRWLockShared(&g_srwLock);
```