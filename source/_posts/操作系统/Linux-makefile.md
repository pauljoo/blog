---
title: Linux-makefile
date: 2018-10-01 11:28:00
categories:
- 操作系统
tags:
- Linux
---

# make命令和makefile文件

make命令和makefile文件的结合提供了一个在项目管理领域十分强大的工具。

makefile文件由一组依赖关系和规则构成。每个依赖关系由一个目标(即将要创建的文件)和一组该目标所依赖的源文件组成。而规则描述了如何通过这些依赖文件创建目标。一般来说，目标是一个单独的可执行文件。

make命令会读取makefile文件的内容，它先确定目标文件或要创建的文件，然后比较该目标所依赖的源文件的日期和时间以决定采用哪条规则来构造目标。通常在创建最终的目标文件之前，它需要先创建一些中间目标。make命令会根据makefile文件来确定目标文件的创建顺序以及正确的规则调用顺序。

## makefile语法

### 依赖关系

依赖关系定义了最终应用程序里的每个文件与源文件之间的关系。

规则的写法是：
目标的名称: [文件] [文件] ...

以下规则表示目标myapp依赖于main.o、2.o和3.o，而main.o依赖于main.h和a.h，等等。

```shell
myapp: main.o 2.o 3.o
main.o: main.c a.h
2.o: 2.c a.h b.h
3.o: 3.c b.h c.h
```

如果想一次创建多个文件，可以利用伪目标all。如果未指定一个all目标，则make命令将只创建它在文件makefile中找到的第一个目标。

```shell
all: myapp myapp.1
```

### 规则

makefile文件的第二部分内容是规则，它们定义了目标的创建方式。规则必须以[tab]开头，不能是空格。

```shell
myapp: main.o 2.o 3.o
  gcc -o myapp main.o 2.o 3.o
```

### 注释

makefile文件中的注释以#号开头。

### 宏

通过语句`MACRONAME=value`在makefile文件中定义宏，引用宏的方法是使用`$(MACRONAME)`或`${MARCRONAME}`。