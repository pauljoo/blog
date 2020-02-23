---
title: emacs
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---
Emacs不仅仅是一个编辑器，他是一个整合环境，或可称它为集成开发环境，这些功能如让使用者置身于全功能的操作系统中。
###开始
启动：emacs [filename]
退出：C-x C-c
挂起：C-z
###按键
C-chr表示当输入字符chr时按住CONTROL键。因此C-f就表示：按住CONTROL键再输入f。
M-chr表示当输入字符chr时按住META（或EDIT或ALT）键。如果你的键盘上没有META、EDIT或ALT键，用下述方法也等效：先按一下ESC键然后放开，再输入chr。我们用ESC来表示ESC键。
###缓冲区
主(major)模式:M-x fundamental-mode
辅助(minor)模式:辅模式并不能替代主模式，而是提供一些辅助的功能。每个辅模式都可以独立地开启和关闭，跟其它辅模式无关，跟主模式也无关。
切换：C-x o
关闭：C-x 1
###窗格
新窗格：C-x 5 2
切换：C-x 5 o
删除当前窗格：C-x 5 0
###菜单
显示和隐藏：M-x menu-bar-mode
调用：F10或者M-`
###配置
.emacs文件包含LISP函数调用表达式，因此它对语法非常挑剔。
###宏
开始录制：C-x (
结束录制：C-x )
执行最后一条宏：C-x e
