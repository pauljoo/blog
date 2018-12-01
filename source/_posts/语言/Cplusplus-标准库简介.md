---
title: C++-标准库简介
date: 2018-11-16 20:04:09
categories:
- 语言
tags:
---
## C++标准的历史
1. C++98 
于1998年批准，是第一份C++标准规格。官方名称是Information Technology - Programming Languages - C++,文档编号ISO/IEC 14882:1998

2. C++03 
这是个所谓“技术勘误”(technical corrigendum, TC)，内含不甚严重的C++98 bug 修正。文档编号ISO/IEC 14882:2003。

3. TR1 
内含大幅度的标准库扩充。官方名称是Information Technology - Programming Languages -Technical Report on C++ Library Extensions,文档编号 ISO/IEC TR 19768:2007。它所涵盖的扩充全部包含于namespace std::tr1内。

4. C++11 
批准于2011年，是第二份C++标准。官方名称Information Technology - Programming Languages -C++,文档编号ISO/IEC 14882:2011。

## C++98和C++11的兼容性
C++的设计目标之一是，对C++98保持向后兼容。

1. C+11
```
#define __cplusplus 201103L
```
2. c++98和c++03
```
#define __cplusplus 199711L
```
向后兼容仅适用于源码，不保证二进制兼容。所以请以C++11编译器重新编译C++98程序的每一份源码。