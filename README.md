# Blog

## 构建
```shell
docker build -t blog:latest .
docker run -d --name=blog --net=host blog
```
## 常用命令

```shell
npm config set registry https://registry.npm.taobao.org
npm install
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