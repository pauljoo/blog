---
title: FAQ-mybatis关于oracle-in-1000个数限制的解决
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---
Oralce in 语句中当in(1,2,3...) 条件数量大于1000将会报错。

如果我们把in拆分成多个in就可以解决这个问题。
修改前


```sql
select *
from tbl_temp
where
id in
<foreach item="item" index="index" collection="ids" open="(" separator="," close=")">
	#{item}
</foreach>
```

```sql
select *
from tbl_temp
where
id in (1,2,3)
```

修改后

```sql
select *
from tbl_temp
where
<foreach item="item" index="index" collection="ids" open="(" separator="or" close=")">
	id in #{item}
</foreach>
```
```sql
select *
from tbl_temp
where
(id in 1 or id in 2 or id in 3)
```


