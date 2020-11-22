---
title: UEFI双系统安装
date: 2020-11-21 16:55:58
categories:
- 其他
tags:
---
## U盘启动盘
### U盘制作
Ultra ISO.
1. 打开ISO文件
2. 选择硬盘映像制作，USB-HDD+

### 分区选择
Unknown System为Windows分区，不要去动。

在默认的Linux分区中
添加/boot, /boot/efi, /, /swap。其中如果是多个硬盘，/boot和/boot/efi需要选择在系统盘中。

## FAQ

### 删除旧的EFI分区
注意：不要删除Windows的分区。

管理员权限打开cmd
```shell
// 运行diskpart.EXE
diskpart
// 列出磁盘
list disk
// 选择你要操作的磁盘
select disk 1
// 列出该磁盘分区
list partition
// 选择需要操作的磁盘分区
select partition 0
// 删除该磁盘分区
delete partition override
```

### 重装时，删除Windows启动项中的旧的系统

1. 管理员权限打开cmd
```shell
// 运行diskpart.EXE
diskpart
// 列出磁盘
list disk
// 选择你要操作的磁盘
select disk 1
// 列出该磁盘分区
list partition
// 选择需要操作的磁盘分区
select partition 0
// win10的EFI分区分配盘符
assign letter=p
```

2. 管理员权限打开另一个cmd
```shell
p:
rmdir /s/q ubuntu
```

3. 重启后，盘符p自动消失