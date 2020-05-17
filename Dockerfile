FROM node:6.17.1

MAINTAINER jianghuiyao jianghuiyao@outlook.com

ADD . /root/blog

CMD ["tail","-f","/dev/null"]