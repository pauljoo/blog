---
title: OpenVPN
date: 2018-11-18 16:56:57
categories:
- 运维
tags:
---

```shell
docker run --cap-add NET_ADMIN -p 2294:2294 -d centos:7 /bin/bash -lc "tail -f /dev/null"

yum install -y epel-release
yum install -y openvpn easy-rsa

cd /usr/share/easy-rsa/3
./easyrsa init-pki
./easyrsa build-ca
./easyrsa build-server-full server nopass
./easyrsa build-client-full client nopass
./easyrsa gen-dh
openvpn --genkey --secret ./pki/ta.key 
cp -pR /usr/share/easy-rsa/3/pki/{issued,private,ca.crt,dh.pem,ta.key} /etc/openvpn/server/

# https://github.com/OpenVPN
curl -O -L https://github.com/OpenVPN/openvpn/archive/v2.4.8.tar.gz
cp /root/openvpn-2.4.8/sample/sample-config-files/server.conf /etc/openvpn/server/
vi /etc/openvpn/server/server.conf

10.8.0.0/24，下一跳为VPN服务器的内网地址192.168.60.113

mkdir /dev/net -pv
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun

openvpn --config /etc/openvpn/server/server.conf
```

```shell
# line 32: change if need (listening port of OpenVPN)
port 1194
# line 35: change if need
proto tcp
;proto udp
# line 78: specify certificates
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/issued/server.crt
key /etc/openvpn/server/private/server.key
# line 85: specify DH file
dh /etc/openvpn/server/dh.pem
# line 101: specify network to be used on VPN
server 10.8.0.0 255.255.255.0
# line 143: uncomment and change to your local network
push "route 172.17.0.0 255.255.255.0"
# line 244: specify TLS-Auth key
tls-auth /etc/openvpn/server/ta.key 0
# line 263: uncomment (enable compress)
comp-lzo
# line 287: change log path
status /var/log/openvpn-status.log
# line 296: change log path
log         /var/log/openvpn.log
log-append  /var/log/openvpn.log
# Notify the client that when the server restarts so it
explicit-exit-notify 0
```
```shell
docker pull python:3.8.2
docker run -d --net=host python:3.8.2 /bin/bash -lc "tail -f /dev/null"
git clone https://github.com/dounine/obfsproxy.git
apt-get update
apt-get install -y python-twisted python-pyptlib python-crypto python-yaml

./bin/obfsproxy obfs3 --dest=127.0.0.1:2294 server 0.0.0.0:3394
./bin/obfsproxy obfs3 --dest=REMOTE:3394 client 0.0.0.0:9999
```
```shell
cp /etc/openvpn/server/ca.crt ./
cp /etc/openvpn/server/ta.key ./
cp /etc/openvpn/server/issued/client.crt ./
cp /etc/openvpn/server/private/client.key ./
```

```shell
remote 192.168.0.1 1194
ca ca.crt
cert client.crt
key client.key 
tls-auth ta.key 1
comp-lzo
dhcp-option DNS 8.8.8.8
dhcp-option DNS 8.8.4.4
redirect-gateway def1
```