---
title: UNIX环境高级编程-文件IO
date: 2018-11-04 11:13:25
categories:
- 操作系统
tags:
---
UNIX系统中的大多数文件IO只需要用到5个函数：open,read,write,lseek,close。
这5个函数通常被称为不带缓冲的IO(unbuffered io)，每个read和write都调用内核中的一个系统调用。
```
int open(const char *pathname, int oflag, ... /* mode_t mode*/);
int close(int filedes);
off_t lseek(int filedes, off_t offset, int whence);
ssize_t read(int filedes, void *buf, size_n nbytes);
ssize_t write(int filedes, const void *buf, size_t nbytes);
```


## IO效率

