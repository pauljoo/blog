---
title: Linux常用命令-awk
date: 2018-11-18 16:56:57
categories:
- 运维
tags:
- Linux常用命令
---
## awk命令形式

```shell
awk [-F|-f|-v] ‘BEGIN{} //{command1; command2} END{}’ file
awk '{print $0}' /etc/passwd
```

|参数名|描述|
|-|-|
|[-F\|-f\|-v]|大参数，-F指定分隔符，-f调用脚本，-v定义变量 var=value|
|'  '|引用代码块|
|BEGIN|初始化代码块，在对每一行进行处理之前，初始化代码，主要是引用全局变量，设置FS分隔符|
|//|匹配代码块，可以是字符串或正则表达式|
|{}|命令代码块，包含一条或多条命令|
|;|多条命令使用分号分隔|
|END|结尾代码块，在对每一行进行处理之后再执行的代码块，主要是进行最终计算或输出结尾摘要信息|

## 常用 awk 内置变量

|变量名|描述|
|-|-|
|$0|当前记录|
|$1-$n|当前记录的第n个字段|
|FS|输入字段分隔符，默认是空格|
|RS|输入记录分隔符，默认是换行符|
|NF|当前记录中的字段个数|
|NR|已经读出的记录数|
|OFS|输出字段分隔符，默认是空格|
|ORS|输出的记录分隔符，默认是换行符|

### BEGIN设置

```shell
awk 'BEGIN{FS=":"}{print $1","$2","$3}' hello.txt
```

## 正则应用
### 规则表达式

`awk '/REG/{action} ' file`,/REG/为正则表达式，可以将$0 中，满足条件的记录送入到：action 进行处理

```shell
awk '/root/{print $0}' passwd
```

### 布尔表达式

`awk '布尔表达式{action}' file`仅当对前面的布尔表达式求值为真时， awk 才执行代码块。

```shell
awk -F: '$1=="root"{print $0}' passwd
```