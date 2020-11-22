---
title: Makefile-使用指南
date: 2020-11-16 20:04:09
categories:
- CPP
tags:
---
## 语法规则
```shell
目标: 依赖
<tab>命令1
<tab>命令2
```

## 简单示例
```
help:
	$(info )
	$(info Makefile help)

all: hello.out
 
hello.out: hello.c
	gcc hello.c -o hello.out

clean:
	rm -rf hello.out
```