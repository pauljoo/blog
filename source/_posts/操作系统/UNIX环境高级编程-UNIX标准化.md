---
title: UNIX环境高级编程-UNIX标准化
date: 2018-11-04 11:13:25
categories:
- 操作系统
tags:
- UNIX环境高级编程
---
20世纪80年代UNIX版本的剧增以及它们之间差别的扩大，导致很多大用户（例如美国政府）呼吁对其进行标准化。所有标准化工作的一个重要部分是对每种实现必须定义的各种限制进行说明。

# UNIX标准化

## ISO C

ISO C标准的意图是提供C程序的可移植性，使其能适合于大量不同的操作系统，而不只是UNIX系统。此标准不仅定义了C程序设计语言的语法和语义，还定义了其标准库。因为所有现今的UNIX系统都提供C标准中定义库例程，所以该标准库是很重要的。
如同大多数标准一样，在批准标准和修改软件以使其符合标准这两者之间有一段时间上的延迟。随着供应商的编译系统不断眼睛，对ISO C标准最新版本的支持也越来越多。
>gcc对ISO C标准1999版本的当前符合程度的总结可见：http://www.gnu.org/software/gcc/c99status.html

按照该标准定义的各个头文件，可将ISO C库分成24个区。

|头文件|FreeBSD 5.2.1|Linux 2.4.22|Mac OS X 10.1|Solaris|说明|
|-|-|-|-|-|-|
|assert.h|x|x|x|x|验证程序断言|
|complex.h|x|x|x||支持复数算数运算|
|ctype.h|x|x|x|x|字符类型|
|errno.h|x|x|x|x|出错码|
|fenv.h||x|x||浮点环境|
|float.h|x|x|x|x|浮点常量|
|inttypes.h|x|x|x|x|整形格式转换|
|iso646.h|x|x|x|x|替代关系操作符宏|
|limits.h|x|x|x|x|实现常量|
|locale.h|x|x|x|x|局部类别|
|math.h|x|x|x|x|数学常量|
|setjmp.h|x|x|x|x|非局部goto|
|signal.h|x|x|x|x|信号|
|stdarg.h|x|x|x|x|可变参数表|
|stdbool.h|x|x|x|x|布尔类型和值|
|srddef.h|x|x|x|x|标准定义|
|stdint.h|x|x|x||整型|
|stdio.h|x|x|x|x|标准I/O库|
|stdlib.h|x|x|x|x|实用程序函数|
|string.h|x|x|x|x|字符串操作|
|tgmath.h||x|||通用类型数学宏|
|time.h|x|x|x|x|时间和日期|
|wchar.h|x|x|x|x|扩展的多字节和宽字符支持|
|wctype.h|x|x|x|x|宽字符分类和映射支持|

>ISO C头文件依赖于操作系统所配置的C编译器版本。FreeBSD 5.2.1配置了gcc 3.3.3版，Solaris 9同时配置了gcc 2.95.3版和gcc 3.2版，Mandrate 9.2 (Linux 2.4.22)配置了gcc 3.3.1版，Mac OS X配置了gcc 3.3版。Mac OS X还包括了gcc的较早版本。

## IEEE POSIX

POSIX是一系列由IEEE制定的标准。POSIX指的是可移植的操作系统接口(Portable Operating System)。它原来指的只是IEEE标准1003.1-1988（操作系统接口），后来则扩展成包括很多标记为1003的标准及标准草案，包括shell和实用程序。
该标准的目的是提高应用程序在各种UNIX系统环境之间的可以执行。它定义了“依从POSIX的”(POSIX compliant)操作系统必须提供的各种服务。
由于1003.1标准定义了一个接口而不是一种实现，所以并不区分系统调用和库函数。标准中的所有例程都称为函数。
标准是不断演变的，1003.1标准也不例外。该标准的1988版，即IEEE 1003.1-1988经修改后提交给ISO。最终的文档作为IEEE Std.1003.1-1990正式出版，这也就是国际标准ISO/IEC 9945-1:1990。该标准通常被称为POSIX.1。
1003.1的2001版与以前各版本有较大的差别，它组合了1003.1的多次修订、1003.2标准以及Single UNIX Specification第2版的若干部分，最终形成了IEEE标准1003.1-2001，其中包括了下列借个标准。

- ISO/IEC 9945-1(IEEE标准1003.1-1996)，它包括

 1. IEEE标准1003.1-1990。
 2. IEEE标准1003.1b-1993(实时扩展)。
 3. IEEE标准1003.1c-1995(pthreads)。
 4. IEEE标准1003.1i-1995(实时技术勘误表)。

- IEEE P1003.1a标准草案(系统接口修订版)。
- IEEE标准1003.1d-1999(高级实时扩展)。
- IEEE标准1003.1j-2000(更高级实时扩展)。
- IEEE标准1003.1q-2000(文件跟踪)。
- IEEE标准1003.2d-1994(批处理扩展)。
- IEEE P1003.2b草案标准(附加的使用程序)。
- IEEE标准 1003.1g-2000(协议无关接口)的某些部分。
- ISO/IEC 9945-2(IEEE标准1003.2-1993)。
- Single UNIX Specification第2版本的基本规范，包括

 1. 系统接口定义，第5发行版。
 2. 命令和使用程序，第5发行版。
 3. 系统接口和头文件，第5发行版。

- 开放组技术标准，网络服务，5.2发行版。
- ISO/IEC 9899:1999，C编程语言。

POSIX.1标准现有Austin Group(http://www.opengroup.org/austin)的开放工作组维护。为了保证它们与实际需求吻合，仍需经常对这些标准进行更新或再修订。

## Single UNIX Specification

Single UNIX Specification（单一UNIX规范）是POSIX.1标准的一个超集，定义了一些附加的接口，这些接口扩展了基本的POSIX.1规范所提供的功能。相应的系统接口全集被称为X/Open系统接口。_XOPEN_UNIX符号常量表示了XSI扩展的几口。
XSI还定义了实现必须支持POSIX.1的哪些可选部分才能认为是遵循XSI的。它们包括文件同步、存储映射文件、存储保护及线程接口。只有遵循XSI的实现才能称为UNIX系统。
## FIPS

FIPS的含义是联邦信息处理标准。它有美国政府出版，用于计算机系统的采购。FIPS 151-1(1989年4月)基于IEEE标准1003.1-1988及ANSI C标准草案。
POSIX.1 FIPS的影响是：它要求任何希望向美国政府销售POSIX.1兼容的计算机系统的厂商应支持POSIX.1的某些可选功能。
