---
title: Unicode
date: 2018-11-04 11:13:25
categories:
- 客户端
tags:
---

Unicode

Unicode是ASCII字符编码的一个扩展。Unicode用的是16位字符编码。

0x0000-0x007F:ASCII码

0x0080-0x00FF:ISO 8859-1 ASCII扩展码


char和宽字符


char *p = "Hello";

wchar_t *pW = L"Hello";

大写的字母L(表示长整型)，这向编译器表明这个字符串将用宽字符存储。


TCHAR.H

       宽字符运行库函数比正常的函数要大。为此你可能希望创建另个版本的程序，一个用ASCII字符串而另一个使用Unicode字符串。而最好的办法则是维护一个单一的源代码文件，但可以编译成ASCII或Unicode。

       但这是有问题的，因为运行库函数具有不同名称，字符变量的定义也不同。

       一个答案是使用包含在Microsoft Visual C++中的TCHAR.H头文件。这个头文件并不是ANSI C标准的一部分，所以其中的每一个函数和宏都有一个下划线前缀。TCHAR.H为那些需要字符串参数的普通运行库函数提供了一系列 的替代名称。这些函数有时被称为“通用”的函数名字，因为它们可以指Unicode或非Unicode版本的函数。


如果一个命名为_UNICODE的标识符被定义了并且TCHAR.H头文件被包含在你的程序中

#define _tcslen wcslen

如果_UNICODE没有被定义

#define _tcslen strlen


同样，_UNICODE定义

typedef wchar_t TCHAR

_UNICODE没有被定义

typedef char TCHAR