---
title: mingw编译librtmp
date: 2018-11-18 16:56:46
categories:
- 多媒体
tags:
---
1  下载
MinGW和MSYS:http://www.mingw.org/
zlib:http://www.zlib.net/
openSSL:http://www.openssl.org/
ActiveState Perl：http://www.perl.org/
rtmpdump:http://rtmpdump.mplayerhq.hu/

2  编译
2.1  编译zlib
```
copy win32\makefile.gcc makefile.gcc
mingw32-make -f makefile.gcc
```
2.2  编译openssl
```
./configure mingw --prefix=`pwd`/win32libs -DL_ENDIAN -DOPENSSL_NO_HW
#修改Makefile和crypto/Makefile文件
#将gcc替换为mingw32-gcc
#将cc替换为mingw32-cc
#修改文件
#md2test.c 
#dummytest.c修改为#include "dummytest.c"
#rc5test.c 
#dummytest.c修改为#include "dummytest.c"
#jpaketest.c
#dummytest.c修改为#include "dummytest.c"
make
make install
```
2.3  编译rtmpdump
2.3.1  依赖文件
将openssl/include下openssl文件夹复制到/MinGW/include目录

将zlib下zconf.h和zlib.h复制/MinGW/include目录

将openssl下(libcrypto.a,libssl.a,ssleay32.lib,libeay32.lib)拷至/MinGW/lib目录

zlib下libz.a拷至/MinGW/lib目录

2.3.2  编译
```
make SYS=mingw
make SYS=mingw install
```