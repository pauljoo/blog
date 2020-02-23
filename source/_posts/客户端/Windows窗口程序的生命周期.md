---
title: Windows窗口程序的生命周期
date: 2018-11-04 11:13:25
categories:
- 客户端
tags:
---
## 程序的执行

当执行Windows程序的时候，加载器加载该程序，然后调用C startup code，再调用程序中WinMain函数入口。

## 初始化

WinMain函数首先通过CreateWindow函数创建窗口，并对窗口进行初始化配置;

## 消息的处理

程序通过循环GetMessage函数不断的从消息队列中抓取消息;

当抓取到消息后，通过DispatchMessage函数将消息分发出去，在DispatchMessage中根据switch/case语句对消息进行判别，并做相应的处理;

## 程序的结束

当收到WM_CLOSE消息的时候，调用DestoryWindow将窗口销毁掉，再调用PostQuitMessage，退出抓取循环。