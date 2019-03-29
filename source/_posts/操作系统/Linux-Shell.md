---
title: Linux-shell
date: 2018-10-01 11:28:00
categories:
- 操作系统
tags:
- Linux
---

shell是一个作为用户与Linux系统间接口的程序，它允许用户向操作系统输入需要执行的命令。

|名|路径|FreeBSD 5.2.1|Linux 2.4.22|Mac OS X 10.3|Solaris 9|
|-|-|-|-|-|-|
|Bourne shell|/bin/sh|.|链接至bash|链接至bash|.|
|Bourne-again shell|/bin/bash|可选的|.|.|.|
|C shell|/bin/csh|链接至tcsh|链接至tcsh|链接至tcsh|.|
|Korn shell|/bin/ksh||||.|
|TENEX C shell|/bin/tcsh|.|.|.|.|

# 管道和重定向

- 重定向输出
- 重定向输入
- 管道

# 脚本和语法

## 第一行

`#!`告诉系统同一行上紧跟在它后面的那个参数是用来执行本文件的程序。

```shell
#!/bin.sh
```

## 语法

### 变量

使用变量之前通常并不需要事先为它们做出声明。
变量赋值时，等号两边不能有空格。
通过在变量名前加一个$符号来访问它的内容。

```shell
a=123
echo $a
```

#### 环境变量

当一个shell脚本程序开始执行时，一些变量会根据环境设置中的值进行初始化。这些变量通常用大写字母做名字，以便它们和用户在脚本程序里定义的变量区分开来。

|环境变量|说明|
|-|-|
|$HOME|当前用户目录|
|$PATH|搜索地址|
|$PS1|命令提示符|
|$PS2|二级提示符|
|$IFS|输入域分隔符|
|$0|shell脚本的名字|
|$#|传递给脚本的参数个数|
|$$|shell脚本的进程号|

#### 参数变量

如果脚本程序在调用时带有参数，一些额外的变量就会被创建。

|环境变量|说明|
|-|-|
|$1,$2,...|脚本程序的参数|
|$*|列出所有|

### 条件

#### test或[

在一些老版本的UNIX shell中，test命令调用的是一个外部程序。可以使用which test来检查执行的是哪一个test命令。

```shell
if test -f fred.c
then
...
fi

if [ -f fred.c ]
then
...
fi
```

|字符串比较|结果|
|-|-|
|string1 = string2||
|string1 != string2||
|-n strng|如果字符串不为空则结果为真|
|-z string|如果字符串为Null(一个空串)则结果为真|

|算术比较|结果|
|-|-|
|expression1 -eq expression2|如果两个表达式相等则结果为真|
|expression1 -ne expression2|如果两个表达式不等则结果为真|
|expression1 -gt expression2|如果expression1大于expression2则结果为真|
|expression1 -ge expression2|如果expression1大于等于expression2则结果为真|
|expression1 -lt expression2|如果expression1小于expression2则结果为真|
|expression1 -le expression2|如果expression1小于等于expression2则结果为真|
|!expression|如果表达式为假则结果为真|

|文件条件测试|结果|
|-|-|
|-d file|如果是目录|
|-e file|如果文件存在|
|-f file|如果是普通文件|
|-g file|如果set-group-id位被设置|
|-r file|如果文件刻度|
|-s file|如果文件大小不为0|
|-u file|如果set-user-id位被设置|
|-w file|如果文件可写|
|-x file|如果文件可执行|

### 控制结构

#### if语句

```shell
if condition
then
  statements
elif
  statements
else
  statements
fi
```

#### for语句

```shell
for variable in values
do
  statements
done
```

#### while语句

```shell
while condition do
  statements
done
```

#### until语句

```shell
until condition
do
  statements
done
```

#### case语句

```shell
case variable in
  pattern [|pattern]...) statements;;
  pattern [|pattern]...) statements;;
  ...
esac

case "$timeofday" in
  yes) echo "Good Morning";;
  no ) echo "Good Afternonn";;
  ...
esac
```

#### AND和OR语句

```shell
statement1 && statement2 && statement3
statement1 || statement2 || statement3
```

#### 语句块

```shell
get_confirm && {
  grep -v "$cdcatnum" $tracks_file > $temp_file
}
```

### 函数

必须在调用一个函数之前先对它进行定义。当一个函数被调用时，脚本程序的位置参数($*,$@,$#,$1等)会被替换为函数的参数。当函数执行完毕后，这些参数会恢复为它们先前的值。

```shell
function_names(){
  statements
}
```

### 命令

#### break命令

用于跳出循环

#### :冒号命令

冒号（:）命令是一个空命令。用于简化条件逻辑，相当于true的别名，比true快。

```shell
# 无限循环
while :

# 条件设置
: ${var:=value}
```

#### continue命令

继续循环

#### .命令

点(.)命令用于在当前shell中执行命令。点命令实在当前上下文中执行命令，所以可以改变当前脚本中的变量参数。

```shell
. ./shell_script
```

#### echo命令

输出字符串

```shell
echo -n "string to output"
```

#### eval命令

对参数进行求值

```shell
foo=10
x=foo
eval y='$'$x
echo $y
#输出10
```

### 命令的执行

```shell
# 旧的语法，反引号
`command`

# 新的语法
$(command)
```

### 调试脚本程序

跟踪脚本程序中复杂错误的主要方法是设置各种shell选项。为此，你可以在调用shell时加上命令行选项，或是使用set命令。

|命令行选项|set选项|说明|
|-|-|-|
|sh -n|set -n|只检查语法错误，不执行命令|
|sh -v|set -v|在执行命令之前回显它们|
|sh -x|set -x|在处理命令之后回显它们|
|sh -u|set -u|如果使用了未定义的变量，就给出出错消息|
