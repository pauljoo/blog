---
title: PostgreSQL-锁
date: 2018-05-26 17:45:54
categories:
- 数据库
tags:
- PostgreSQL
---
在PostgreSQL数据库中有两类锁：表级锁和行级锁。当要查询、插入、更新、删除表中的数据时，首先是要获得表上的锁，然后再获得行上的锁。

## 表级锁模式

|锁模式|解释|
|-|-|
|ACCESS SHARE|多版本控制功能，修改数据下也允许读数据|
|ROW SHARE|意向共享锁|
|ROW EXCLUSIVE|意向独占锁|
|SHARE UPDATE EXCLUSIVE|在意向独占锁的基础上，自身会排斥|
|SHARE|读锁，表的内容不能再变化|
|SHARE ROW EXCLUSIVE|SHARE+ROW EXCLUSIVE|
|EXCLUSIVE|写锁，其他进程不能写也不能读|
|ACCESS EXCLUSIVE|多版本控制功能，也不允许访问数据|

PostgreSQL中有8种表锁，最普通的是共享锁“SHARE”和排他锁“EXCLUSIVE”，因为多版本的原因，修改一条语句的同时，允许了读数据，为了处理这种情况，又增加了两种锁“ACCESS SHARE”和“ACESS EXCUSIVE”，锁中的关键字“ACCESS”是与多版本相关的。此外，为了处理表锁和行锁之间的关系，有了“意向锁”的概念，这时又加了两种锁，即“意向共享锁”和“意向排他锁”，由于意向锁之间不会产生冲突，而且意向排它锁相互之间也不会产生冲突，于是又需要更严格一些的锁，这样就产生了“SHARE UPDATE EXCLUSIVE” 和 “SHARE ROW EXCLUSIVE”

## 行级锁模式

只有共享锁和独占锁。

## 死锁

PostgreSQL能够自动侦测到死锁，然后会退出其中一个事务，从而允许其他事务完成。不过，到底哪个事务会被退出是很难估计的。

## 表级锁命令

```shell
LOCK TABLE name [NOWAIT]
```

在PostgreSQL中，事务自己的锁是从不冲突的。

## 行级锁命令

```shell
SELECT FOR [UPDATE | SHARE] [OF table_name] [NOWAIT]
```

多表关联时，可以使用`of table`指定表名。

## 锁的查看

```
SELECT * FROM pg_locks
```