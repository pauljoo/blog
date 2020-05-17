FROM node:6.17.1

MAINTAINER jianghuiyao jianghuiyao@outlook.com

ENV LANG C.UTF-8

COPY sources.list /etc/apt/sources.list

ADD . /root/blog

CMD ["tail","-f","/dev/null"]
