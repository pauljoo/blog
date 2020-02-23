---
title: FAQ-LoadLibrary找不到指定的模块
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---

1. 到网上下载一个Dependency Walker(简称depends)工具，该工具主要是用来检查某个文件的运行需要使用哪些链接库。下载后直接双击Depends.exe打开，然后点文件-〉打开，选择你要检查的文件，然后会出现下面的画面：

{% asset_img FAQ-LoadLibrary找不到指定的模块-1.png %}

可以看到左上角是该控件所需要的所有的动态链接库，右边是每个链接库的具体信息，最下面一栏显示状态，之前因为少装了4个链接库，下面就会显示缺少xxxx，中间的那部分第一栏模块名称那里会用红色表示缺少的模块。

2. 到网上找到那几个链接库，然后把它们放到%systemroot%\WINDOWS\system32下面。

3. 在开始-〉运行里键入regsvr32 xxxxx.ocx，该控件就成功注册了！