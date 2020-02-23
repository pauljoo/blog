# Blog

```dockerfile
FROM centos:centos7.7.1908

RUN yum install -y epel-release && \
yum install -y nodejs && npm install hexo-cli -g 

ENTRYPOINT ["tail", "-f", "/dev/null"]
```
## 常用命令

```shell
hexo clean
hexo generate
hexo deploy
```

## 插件

### Next主题

### hexo-tag-plantuml

### hexo-deployer-git

### hexo-generator-search

### MathJax数学公式