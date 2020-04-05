---
title: vim
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---
# vim

```shell
mv ~/.vimrc ~/.vimrcbak
mv ~/.vim ~/.vimbak
git clone https://github.com/pauljoo/vim.git
mv vim/.vimrc vim/.vim ~/
```
## 基本
### pathogen
一个管理插件的插件

#### 项目地址
https://github.com/tpope/vim-pathogen

#### 安装

### auto-pairs
自动匹配括号、引号等

#### 项目地址
https://github.com/jiangmiao/auto-pairs

###  NERDTree
显示目录树

#### 项目地址
https://github.com/scrooloose/nerdtree

#### 使用
1. 命令行模式下输入:NERDTree
2. 为了方便打开NERDTree，我们可以设置快捷键，打开~/.vimrc，插入如下一行
map <C-n> :NERDTree<CR>
这样，当打开vim时，只要输入ctrl+n即可打开NERDTree

```shell
文件相关操作
o  : 在光标所在的上一个窗口打开文件，并将光标置于新打开的窗口
go : 预览文件，光标停留在NERDTree窗口中
t  : 在新标签中打开文件并激活
gt : 在新标签打开文件，光标留在NERDTree窗口中
i  : 水平分割打开文件
gi : 水平分割预览
s  : 垂直分割打开文件
gs : 垂直分割预览
目录树相关操作
o  : 展开/关闭目录
O  : 递归展开目录。慎用，如果目录层级多，打开会很慢
x  : 关闭父目录
C  : 切换光标所在目录为根目录
u  : 切换目录树的根目录为上层目录
U  : 切换目录树的根目录为上层目录，并保持旧的目录树的状态
r  : 刷新当前目录
R  : 刷新当前根目录（这个在新加入文件后会用到）
cd : 切换vim工作目录为光标所在目录（命令模式下:pwd可查看当前工作目录）
```

### MiniBufExplorer
显示已打开的buffer

#### 项目地址
http://www.vim.org/scripts/script.php?script_id=159

#### 使用
命令行模式下通过:vsp filename打开另一个文件

## 代码

### ctags

### taglist

### omnicppcomplete
