---
title: MinGW编译x264
date: 2018-11-18 16:56:46
categories:
- 多媒体
tags:
---
1  准备

yasm:http://yasm.tortall.net/

x264:http://www.videolan.org/developers/x264.html

下载对应系统的yasm放到/MinGW/msys/1.0/bin下，重新命名为yasm.exe
2  编译


./configure --enable-shared
make


