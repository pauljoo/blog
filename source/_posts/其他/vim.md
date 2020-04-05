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

1. 管理插件的插件
2. 管理窗口和buffer
3. 语法增强
4. 代码补全

## 基本
### pathogen
一个管理插件的插件

#### 项目地址
https://github.com/tpope/vim-pathogen

#### 安装

#### 配置
```shell
execute pathogen#infect()
syntax on
filetype plugin indent on
```
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
```shell
mkdir -p ~/.vim/bundle/minibufexplorer/plugin && wget "http://www.vim.org/scripts/download_script.php?src_id=3640" -O ~/.vim/bundle/minibufexplorer/plugin/minibufexpl.vim
```

#### 使用
命令行模式下通过:vsp filename打开另一个文件

## 代码

### ctags
是用来对代码建索引，方便查找的，有些Linux版本是自带ctags的，如果没有，按如下方式安装
#### 安装
```shell
yum install ctags
```

### taglist
taglist是vim的一个插件，可以将代码内的函数、变量等按规律列出来，方便查找

#### 项目地址
http://www.vim.org/scripts/script.php?script_id=273 

#### 目录结构
```shell
taglist
|-- doc
|   |-- taglist.txt
|-- plugin
  |-- taglist.viml
```

#### 配置
打开~/.vimrc，输入如下内容
```shell
let Tlist_Show_One_File=1    " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
let Tlist_Sort_Type="name"   " tag按名字排序
```
### omnicppcomplete
这是一个对C++进行语法补全的插件，可以对函数、命名空间、类成员等进行补全，使用起来和绝大多数IDE差不多，不一样的是IDE为你做了很多你不知道的事情，而omni补全需要依赖tags文件，需要你用ctags命令自己生成

#### 项目地址
```shell
cd ~/.vim/bundle && wget "http://www.vim.org/scripts/download_script.php?src_id=7722" -O omnicppcomplete.zip && unzip omnicppcomplete.zip -d omnicppcomplete
```
#### 目录结构
```shell
    ├── after
    │   └── ftplugin
    │       ├── cpp.vim
    │       └── c.vim
    ├── autoload
    │   └── omni
    │       ├── common
    │       │   ├── debug.vim
    │       │   └── utils.vim
    │       └── cpp
    │           ├── complete.vim
    │           ├── includes.vim
    │           ├── items.vim
    │           ├── maycomplete.vim
    │           ├── namespaces.vim
    │           ├── settings.vim
    │           ├── tokenizer.vim
    │           └── utils.vim
    └── doc
        └── omnicppcomplete.txt
```

#### 配置
打开~/.vimrc，输入如下内容
```shell
filetype plugin indent on
set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer   and in included files
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
```
#### 手动建立tags文件
omni插件的补全是依赖于tags文件的
```shell
ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++
```
### SuperTab
你想要补全变量名或函数名只需按一下TAB键即可，出现候选窗口之后也可以用TAB键进行选择

#### 项目地址
https://github.com/ervandew/supertab