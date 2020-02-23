---
title: FAQ-error-LNK2005
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---

如果在编译MFC程序的时候出现下列及类似的错误：


1>uafxcwd.lib(afxmem.obj) : error LNK2005: "void * __cdecl operator new(unsigned int)" (??2@YAPAXI@Z) 已经在 LIBCMTD.lib(new.obj) 中定义
1>uafxcwd.lib(afxmem.obj) : error LNK2005: "void __cdecl operator delete(void *)" (??3@YAXPAX@Z) 已经在 LIBCMTD.lib(dbgdel.obj) 中定义
1>uafxcwd.lib(afxmem.obj) : error LNK2005: "void * __cdecl operator new[](unsigned int)" (??_U@YAPAXI@Z) 已经在 libcpmtd.lib(newaop.obj) 中定义
1>uafxcwd.lib(afxmem.obj) : error LNK2005: "void __cdecl operator delete[](void *)" (??_V@YAXPAX@Z) 已经在 LIBCMTD.lib(delete2.obj) 中定义

解决方法如下：
项目属性页-》链接器-》输入

做如下改动，注意顺序

附加依赖库：uafxcwd.lib;LIBCMTD.lib;


忽略特定默认库：LIBCMTD.lib;uafxcwd.lib


转自:http://blog.csdn.net/dotphoenix/article/details/13511863
