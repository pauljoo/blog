---
title: FAQ-DLL生成DEF-DEF生成LIB
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---

DLL生成DEF

使用方法，将pexports.exe放到X:\Microsoft Visual Studio X.0\VC\bin目录下，在命令行里输入pexports x.dll > x.def

DEF生成LIB

然后在输入lib /machine:ix86 /def:x.def
即在当前目录生成x.lib