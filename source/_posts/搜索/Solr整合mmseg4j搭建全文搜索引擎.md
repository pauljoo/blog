---
title: Solr整合mmseg4j搭建全文搜索引擎
date: 2018-11-18 16:56:57
categories:
- 搜索
tags:
- Solr
---
## 下载
solr:http://lucene.apache.org/solr/
mmseg4j:https://code.google.com/p/mmseg4j/
oracle
tomcat-7.0.39:http://tomcat.apache.org/

## 简介
### Solr
Lucene是apache软件基金会4 jakarta项目组的一个子项目，是一个开放源代码的全文检索引擎工具包，即它不是一个完整的全文检索引擎，而是一个全文检索引擎的架构，提供了完整的查询引擎和索引引擎，部分文本分析引擎（英文与德文两种西方语言）。
Solr是一个高性能，基于Lucene的全文搜索服务器。同时对其进行了扩展，提供了比Lucene更为丰富的查询语言，同时实现了可配置、可扩展并对查询性能进行了优化，并且提供了一个完善的功能管理界面，是一款非常优秀的全文搜索引擎。

### mmseg4j
mmseg4j用Chih-Hao Tsai 的MMSeg算法实现的中文分词器，并实现lucene的analyzer和solr的TokenizerFactory以方便在Lucene和Solr中使用。 MMSeg 算法有两种分词方法：Simple和Complex，都是基于正向最大匹配。Complex加了四个规则过虑。官方说：词语的正确识别率达到了 98.41%。mmseg4j已经实现了这两种分词算法。

### zookeeper
ZooKeeper是一个分布式的，开放源码的分布式应用程序协调服务，是Google的Chubby一个开源的实现，是Hadoop和Hbase的重要组件。它是一个为分布式应用提供一致性服务的软件，提供的功能包括：配置维护、名字服务、分布式同步、组服务等。

## 配置
将solr-4.5.0.zip解压开后，复制/example/webapps/solr.war复制到tomcat/webapp目录下

- 配置solr/home
/conf/Catalina/localhost/solr.xml
```xml
<Context docBase="../solr/solr.war" debug="0" crossContext="true">
  <Environment name="solr/home" type="java.lang.String" value="../solr" override="true"/>
</Context>
```
- 配置数据库信息
/solr/collection1/conf/solrconfig.xml
```xml
<lib dir="../../../../dist/" regex="solr-dataimporthandler-.*\.jar" />
<requestHandler name="/dataimport" class="org.apache.solr.handler.dataimport.DataImportHandler">
    <lst name="defaults">
    	<str name="config">db-data-config.xml</str>
    </lst>
</requestHandler>
```
增加业务数据库相应信息
/solr/collection1/conf/db-data-config.xml 

- 配置分词信息
/solr/collection1/conf/schema.xml
```xml
<field name="SUMMARY" type="text_cn" indexed="true" stored="true"/>
<!-- Chinese -->
<fieldType name="text_cn" class="solr.TextField" positionIncrementGap="100">
	<analyzer type="index">
	    <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="complex" dicPath="dic"/>
	</analyzer>
	<analyzer type="query">
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="complex" dicPath="dic"/>
    </analyzer>
</fieldType>
```
- 配置solr cloud信息
/tomcat/solr/solr.xml 
```xml
<solrcloud>
    <str name="host">127.0.0.1</str>
    <int name="hostPort">5080</int>
    <str name="hostContext">${hostContext:solr}</str>
    <int name="zkClientTimeout">${zkClientTimeout:15000}</int>
	<bool name="genericCoreNodeNames">${genericCoreNodeNames:true}</bool>
</solrcloud>
```
到/tomcat/bin目录下。编辑catalina.bat文件。在文件最开始增加：
```bat
set JAVA_OPTS=-Dbootstrap_confdir=../solr/collection1/conf -Dcollection.configName=clusterconf -DzkRun=127.0.0.1:9001 -DzkHost=127.0.0.1:9001,127.0.0.1:9002,127.0.0.1:9003 -DnumShards=1
```

```bat
set JAVA_OPTS=-Dbootstrap_confdir=../solr/collection1/conf -Dcollection.configName=clusterconf -DzkRun=127.0.0.1:9002 -DzkHost=127.0.0.1:9001,127.0.0.1:9002,127.0.0.1:9003 -DnumShards=1
```

```bat
set JAVA_OPTS=-Dbootstrap_confdir=../solr/collection1/conf -Dcollection.configName=clusterconf -DzkRun=127.0.0.1:9003 -DzkHost=127.0.0.1:9001,127.0.0.1:9002,127.0.0.1:9003 -DnumShards=1
```

- 配置zookeeper信息
/tomcat/solr/zoo.cfg
修改zoo.cfg文件，增加如下内容：
```xml
# the port at which the clients will connect
clientPort=9001
# NOTE: Solr sets this based on zkRun / zkHost params
server.1=127.0.0.1:2888:2889
server.2=127.0.0.1:3888:3889
server.3=127.0.0.1:4888:4889
```
tomcat 5080设为9001
tomcat 6080设为9002
tomcat 7080设为9003

- 新建myid
/tomcat/solr/oo_data目录下，新建文件myid
tomcat 5080设内容为1
tomcat 6080设内容为2
tomcat 7080设内容为3