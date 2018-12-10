---
title: Java-线程池
date: 2018-11-16 20:04:09
categories:
- Java
tags:
---
1.减少创建线程的次数
2.控制线程池大小，减少并发线程数目

|方法|描述|
|-|-|
|newCachedThreadPool|必要时创建新线程，空闲线程会被保留60秒|
|newFixedThreadPool|该池包含固定数量的线程，空闲线程会一直被保留|
|newSingleThreadExecutor|只有一个线程的池，该线程顺序执行每一个提交的任务|
|newScheduledThreadPool|用于预定执行而构建的固定线程池，替代Timer|
|newSingleThreadScheduledExecutor|用于预定执行而构建的单线程“池”|
