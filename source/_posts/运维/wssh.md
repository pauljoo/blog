---
title: WSSH
date: 2018-11-18 16:56:57
categories:
- 运维
tags:
---
## WSSH
wssh 是一个 SSH 到 WebSockets 的桥，可以让你通过 HTTP 调用远程服务器的 SHELL 命令。 
wssh 可以让我们通过 HTTP 来调用远程的一个 shell，也就是说我们可以用浏览器来访问某个 Linux 服务器／虚拟机的终端（只要这个服务器上运行了 wsshd 服务器端）。

## 安装
操作系统:CentOS 7 
python:2.7

```
yum install gcc python-devel openssl-devel
pip install gevent flask paramiko gevent-websocket
```

下载jquery-1.12.3.js和term.js到本地 
修改/wssh-0.1.0/wssh/templates/index.html 
修改前:
```
<script type="application/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
</script>
<script type="application/javascript" src="https://raw.github.com/chjj/tty.js/36717df8e96f35f4e2bd3fd585e9361f1439fc7e/static/term.js">
</script>
```
修改后:
```
<script type="application/javascript" src="{{url_for('static', filename='jquery-1.12.3.js')}}">
</script>
<script type="application/javascript" src="{{url_for('static', filename='term.js')}}">
</script>
```
>python setup.py install

启动wsshd

>wsshd

## FAQ
报错: 
/usr/lib/python2.7/site-packages/wssh-0.1.0-py2.7.egg/EGG-INFO/scripts 
修改前:
```
from geventwebsocket import WebSocketHandler
```
修改为:
```
from geventwebsocket.handler import WebSocketHandler
```