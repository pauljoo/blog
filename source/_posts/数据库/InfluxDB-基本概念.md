---
title: InfluxDB-基本概念
date: 2018-05-26 17:45:54
categories:
- 数据库
tags:
---
InfluxDB是一个无模式数据库，可以随时添加新的measurement,tags和fields。

1. database
数据库可以包含多个用户、保留策略、连续查询和时间序列数据的逻辑容器。

2. measurement
measurement是包含timestamp, field和tag的容器。相当于数据库中的表。

3. timestamp
时间戳

4. field
字段由字段键(field key)和字段值(field value)构成。字段是InfluxDB中必须存在的，没有字段就不能保存数据。相当于表中的列名和列的值。
但是，字段不能进行索引，进行字段匹配的时候会导致全表扫描。如果需要作为查询条件，需要设置为tags。

5. tags
标签由标签键(tag key)和标签值(tag value)构成。不同于字段，标签是可选，同时是被索引的。标签适合存储查询用的元数据。

6. point
同一个序列(serie)和时间戳(timestamp)中的字段集(field set)。

7. retention policy
保留策略描述了InfluxDB保存数据的持续时间，这些数据的副本数量以及分片组覆盖的时间范围。

8. series
InfluxDB数据结构中的数据集合，共享measurement、retention policy、measurement和tag set

## 安装
root权限

## 网络端口

8086:用于客户端和服务器之间的通信

8088:用于备份和还原

## 配置
```
influxd config
influxd --config /etc/influxdb/influxdb.conf
```