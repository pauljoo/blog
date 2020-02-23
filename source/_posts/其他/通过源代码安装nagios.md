---
title: 通过源代码安装nagios
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---
目的

这个文档描述了如何在CentOS和Ubuntu服务器上通过源代码安装Nagios Core和Nagios Plugins


目标读者

所有想要通过源代码安装Nagios Core


先决条件

Ubuntu

执行这个文档里面的所有步骤使用root权限，下面的命令可以切换到root shell。
sudo -i



在不同的平台安装Nagios，对于依赖包的要求会有所不同。
RHEL/CentOS:
yum install -y wget httpd php gcc glibc glibc-common gd gd-devel make net-snmp


Ubuntu:
sudo apt-get install wget build-essential apache2 php5-gd libgd2-xpm libgd2-xpm-dev libapache2-modphp5




下载Nagios Core和Nagios Plugins Tarballs

所有系统，在你的终端中运行以下命令:
cd /tmp
wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.4.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.tar.gz
这里会下载Nagios Core和它所要求的插件



增加Nagios用户和组

为了Nagios进程的运行增加适当的用户和组
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios



Nagios Core安装

tar zxvf nagios-4.0.4.tar.gz
tar zxvf nagios-plugins-2.0.tar.gz
切换到Nagios目录然后安装package：
cd nagios-4.0.4

RHEL/CentOS:
./configure --with-command-group=nagcmd
Ubuntu:
./configure --with-nagios-group=nagios --with-command-group=nagcmd -–with-mail=/usr/bin/sendmail

所有系统:
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf
cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
/etc/init.d/nagios start

RHEL/CentOS:
/etc/init.d/httpd start



创建一个默认用户用于Web访问

htpasswd –c /usr/local/nagios/etc/htpasswd.users nagiosadmin



Nagios Plugin安装

cd /tmp/nagios-plugins-2.0
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install



Nagios Service设置

下面的命令会注册系统启动时运行Nagios守护进程
chkconfig --add nagios
chkconfig --level 35 nagios on
chkconfig --add httpd
chkconfig --level 35 httpd on

Ubuntu:
ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios
Nagios Web界面

在安装正确的步骤安装后，你可以通过web浏览器访问Nagios Core。
使用一下：
http://<your.nagios.server.ip>/nagios
使用你在向htpasswd.users文件里增加nagiosadmin用户时你选择的凭证。