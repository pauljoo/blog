---
title: UNIX环境高级编程-UNIX标准化
date: 2018-11-04 11:13:25
categories:
- 操作系统
tags:
- UNIX环境高级编程
---
## UNIX体系结构

UNIX的体系结构大致分为以下几个层次：
第一层：内核  
第二层：系统调用  
第三层：shell和库函数  
第四层：应用软件  

## 输入和输出

每当运行一个新程序时，所有的shell都为其打开三个文件描述符：标准输入、标准输出、标准出错。

```shell
./a.out < in file > outfile
```

## 出错处理

当UNIX函数出错时，常常返回一个负值。文件errno.h中定义了符号errno以及可以赋予它的各种变量。

```c
// 单线程
#include <errno>
extern int errno;

// 多线程
#include <errno>
extern int *__errno_location(void);
#define errno (*__errno_location())
```

errno的打印函数

```c
#include <string.h>
char *strerror(int errnum);

#include <stdio.h>
void perror(const char *msg);
```