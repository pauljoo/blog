---
title: Maven指南
date: 2018-11-16 20:04:09
categories:
- Java
tags:
---

## 项目对象模型（POM）

### 插件和目标

一个Maven插件是一个单个或者多个目标的集合。如下面的例子，archtype是一个插件标识，create是目标标识
```shell
mvn archtype:create
```

### 生命周期

命令行并没有指定一个插件目标，而是指定了一个Maven生命周期阶段。命令行是如何执行目标的呢?

插件目标可以被绑定到生命周期阶段上。每个阶段可以绑定0个或者多个目标。当执行到该阶段就会执行该阶段上的目标。

Maven中有三种标准的生命周期：清理（clean），默认（default）(有时候也称为构建)，和站点（site）。默认的Maven生命周期包含了process-resources, compile, process-classes, process-test-resources, test-compile, test, prepare-package, package等等。

```shell
mvn package
```

### 坐标

POM定义了项目，提供了项目的一组唯一标识符(坐标)，并且通过依赖(dependencies)，父(parents)和先决条件(prerequisite)来定义了和其他项目的关系。

一个Maven坐标可以精确的定位一个项目。格式如下:
```
groupId:artifactId:packageing:version
```

### 仓库

Maven仓库的标准是按照下面的目录格式来存储构件：

```
/<groupId>/<artifactId>/<version>/<artifactId>-<version>.<packaging>
```

### 依赖管理

一个复杂的项目将会包含很多依赖，也有可能包含依赖于其它构件的依赖。这是Maven最强大的特征之一，它支持了传递性依赖（transitive dependencies）。假如你的项目依赖于一个库，而这个库又依赖于五个或者十个其它的库（就像Spring或者Hibernate那样）。你不必找出所有这些依赖然后把它们写在你的pom.xml里，你只需要加上你直接依赖的那些库，Maven会隐式的把这些库间接依赖的库也加入到你的项目中。Maven也会处理这些依赖中的冲突，同时能让你自定义默认行为，或者排除一些特定的传递性依赖

### 站点生成和报告

Site生命周期只关心处理在src/site目录下的site内容，还有生成报告。在这个命令运行过之后，你将会在target/site目录下看到一个项目web站点。载入target/site/index.html你会看到项目站点的基本外貌。

```
mvn site
```

## 插件开发

Maven的核心是一个名为Plexus的反转控制（IoC）框架。

一个Maven插件是包含了一个插件描述符和一个或者多个Mojo的Maven构件。一个Mojo可以被认为是Maven中的一个目标，每一个目标对应了一个Mojo。

### POM定义

```
<packaging>maven-plugin</packaging>
```

### 实现Mojo接口

继承AbstractMojo，实现一个目标接口。

### Mojo中常用注解

```
@goal <goalName>
@requiresDependencyResolution <requireScope>
@requiresProject (true|false)
@requiresReports (true|false)
@aggregator (true|false)
@requiresOnline (true|false)
@requiresDirectInvocation
@phase <phaseName>
@execute [goal=goalName|phase=phaseName [lifecycle=lifecycleId]]
```

### Mojo失败

MojoExecutionException：一个致命的异常，发生了一些不可恢复的错误。构建需要终止。
MojoFailureException：Maven遇到项目失败的时候，他会提供不同的“弹性”设置。mvn -ff mvn -fae mvn -fn等等。