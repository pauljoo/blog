---
title: InfluxDB-数据库管理
date: 2018-05-26 17:45:54
categories:
- 数据库
tags:
---
## database

```
CREATE DATABASE <database_name> [WITH [DURATION <duration>] [REPLICATION <n>] [SHARD DURATION <duration>] [NAME <retention-policy-name>]]

DROP DATABASE <database_name>
```

## series

```
DROP SERIES FROM <measurement_name[,measurement_name]> WHERE <tag_key>='<tag_value>'
```

## measurement

```
DROP MEASUREMENT <measurement_name>
```

## retention policy

```
CREATE RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> [SHARD DURATION <duration>] [DEFAULT]
```