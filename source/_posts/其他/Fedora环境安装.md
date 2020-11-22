---
title: Fedora环境安装
date: 2020-11-21 16:55:58
categories:
- 其他
tags:
---

## yum源替换
https://mirrors.tuna.tsinghua.edu.cn/help/fedora/

## windows工具栏安装
```
yum install gnome-tweak-tool
```
修改配置

Tweaks->Extensions

## 中文输入法安装
Settings->Region&Language->Input Source

## 添加菜单项
/usr/share/applications
Visual_Studio_Code.desktop
```shell
[Desktop Entry]
Version=1.0
Type=Application
Name=Visual_Studio_Code
Icon=/data/work/tool/VSCode-linux-x64/resources/app/resources/linux/code.png
Exec="/data/work/tool/VSCode-linux-x64/bin/code"
Comment=Develop with pleasure!
Categories=Development;
Terminal=false
```