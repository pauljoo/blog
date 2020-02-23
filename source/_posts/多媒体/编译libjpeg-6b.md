---
title: 编译libjpeg-6b
date: 2018-05-26 21:57:10
categories:
- 多媒体
tags:
---
1、下载libjpeg的源代码jpegsr6.zip

2、解压出来一堆文件，打开命令行窗口（CMD），进入代码所放的目录下

3、运行命令：nmake /f makefile.vc nodebug=1 开始编译，然后问题就来了

4、“nmake 不是内部或外部命令”
  这个执行文件在VC的安装目录中，解决方法：输入命令 path C:\Program Files\Microsoft Visual Studio 9.0\VC\bin; %SystemRoot%\system32;回车

5、makefile.vc<11>:fatal error U1052: file 'win32.mak' not found
  提示找不到win32.mak文件，这个文件定义了一些必须的宏，这个文件在Windows SDK的安装目录中，打开makefile.vc文件修改第12行为：
  !include <C:\Program Files\Microsoft SDKs\Windows\v6.0A\Include\win32.mak>
  保存，再执行编译命令又有新的错误。

6、NMAKE:fatal error U1073: don't know how to make 'jconfig.h'
  这是个奇怪的问题，在网上搜了半天没有结果，最后才发现原来目录中没有这个文件。其实只要把文件jconfig.vc更名为jconig.h即可。再执行编译命令又有新的错误。

7、NMAKE: fatal error U1077: '...\cl.EXE' : return code '0xc0000135'
  CL命令未能执行，我们直接在命令行提示后面输入cl回车，会有个提示“没有找到 mspdb80.dll ”。解决方法：输入 vcvars32 回车，这是一个用来设置VC路径环境的批处理。再次执行编译命令，出现了一行行字符快速的刷新，哈哈，已经开始编译了。最后又出现一个错误，这个就不用管它了，因为我们需要的libjpeg.lib文件已经出现在了当前目录中。