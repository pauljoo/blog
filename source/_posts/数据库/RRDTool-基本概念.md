---
title: RRDTool-基本概念
date: 2018-05-26 17:45:54
categories:
- 数据库
tags:
---

rrdtool是一个固定大小的，基于文件的时序数据库。

## 基本概念

PDP(Primary Data Point)：主数据点
CDP（Consolidation Data Point）：聚合数据点
解析度（resolution）：指的就是时间跨度
DS（Data Source）：数据源，每一个数据源都可以对其做单独的聚合

## rrdtool create

```shell
rrdtool create filename [--start|-b start time] [--step|-s step]
                        [DS:ds-name:DST:dst arguments]  
                        [RRA:CF:cf arguments]
filename:    默认为.rrd为后辍的文件，名称自己随意取；
--start:     指定RRDtool的第一个记录的起始时间，--start选项的值必须是timestamp的格式。
             如查你想自己设定时间可以使用--start $(date -d '1 days ago' +%s) ,当然还有一种方法就是使用rrdtool fetch filename.rrd AVERAGE；
--step:      就是RRDtool“期望”每隔多长时间就收到一个值；
DS：         用于定义数据源；
ds-name:     指定数据源的名字，随意取。必须是1到19个字符，且是a-z、A-Z、或者0-9；
DST：        定义源数据类型，源数据类型分以下几种：
                    1、COUNTER      数据必须是递增的，保存的是相对于前面的一个值
                    2、GAUGE        保存原值
                    3、DERIVE       可增可减
                    4、ABSOLUTE     相对于初始值的数值
                    5、COMPUTE      对于COMPUTE数据源来说格式是DS:ds-name:COMPUTE:rpn-expression
dst argument:数据源参数，形式是:    heartbeat:min:max
                 heartbeat：  定义在我们这个时间跨度之内，再过多长时间过期，过期的标记为unknown；
                 min：        接收的最小值，一般我们可以都设为0；
                 max：        接收的最大值，如果不是很清楚其最大值可以设置为U；
RRA：        用于指定数据如何存放；
CF:          指定数据合并方法，合并方法分以下几种：
                    1、AVERAGE    平均值
                    2、MAX        最大值
                    3、MIN        最小值
                    4、LAST       当前值
cf arguments:数据保存，它的形式是：    xff:steps:rows
              xff:        定义PDP中出现unknown的百分比高于设置的这个比例以后CDP也被标记为unknown；
              steps：     聚合函数对多少个pdp做聚合生成cdp；
              rows：      保存多少个聚合的cdp结果；
```

## rrdtool update

```
rrdtool {update | updatev} filename [--template | -t ds-name[:ds-name]...]
[--] N | timestamp:value[:value...]
-t ：    改变接收数据的次序
            例如，我们定义的rrdtool create test.rrd DS：ds1 DS：ds2，默认情况下我们想这个数据库里面输入值得话是：rrdtool update test.rrd N:30（DS1值）:40（DS2值），
            使用rrdtool update test.rrd -t  ds2:ds1 40:30 把循序给颠倒; 
N:       表示当前时间
```

## rrdtool info

```
rrdtool info filename    用于查看filename的数据结构（filename就是rrdtool create生成的数据库文件）；
```

## rrdtool fetch

```
rrdtool fetch filename [-r #] [CF]
-r #:    指定#个PDP为一个数据；
CF:      指定使用哪种合并函数，与rrdtool create中cf argument一样；
```

## rrdtool graph

```
rrdtool graph|graphv filename [option ...][datadefinition ...][data calculation ...][variabledefinition ...][graph element ...][print element ...]
[-s|--start time][-e|--end time][-S|--step seconds]
[-t|--title string][-V |--Vertical-label string ]
[-w|--width pixels][-h|--height pixels][-j|--only-graph][-D|--full-size-mode]
 
OPTION：
Graph Limits
[-u | --upper-limit value]:     显示数值的最大上限的值
[-l | --lower-limit value]：    显示的最低下限的值
[-r | --rigid ]:                不会自动缩放，以定义的最大值和最小值来显示
[-A | --alt-autoscale ]:        启用自动缩放，但是最大的和最小的是不能超过上面的范围
[-J | --alt-autoscale-min]:     只自动缩放最小值
[-M | --alt-autoscale-max ]:    只自动缩放最大值
[-N | --no-gridfit]:            不显示网格线
 
定义横轴：
X-Axis
    [-x|--x-grid GTM:GST(定义基准网格线，前面是单位，后面是数值)
    :MTM:MST（定义主网格线，前面的是单位，后面的是数值）
    :LTM:LST（定义横轴底面的标签的单位和距离，前面是单位，后面是距离）
    :LPR:LFM（显示标签的显示格式）]
    [-x | --x-grid none ]
 
Y-Axis
    [-y|--y-grid grid(刻度是什么) step(多长显示一个刻度)
    :label（卷标显示是什么） factor（卷标多长时间显示一个）]:
    [-y|--y-grid none ]
    [-Y| --alt-y-grid]
 
图片全局定义
   [-c| --color COLORTAGE #rrggbb[aa]]
       BACK          #背景色
       CANVAS        #画布颜色
       SHADEA        #左边和上边的颜色
       SHADEB        #右边和下边的颜色
       GRID，MGRID   #主网格线的颜色
       FONT          #字体颜色
       AXIS          #坐标轴的颜色
       FRAME         #边框颜色
       ARROW         #箭头的颜色
    -n | --font FONTTAG（字体名字）：size（大小）：[font（路径）]   #指定字体的参数
    [-R|--font-render-mode(字体格式) {normal（正常）,light（发亮）,mono（粗体）}]
    [-a|--imgformat PNG|SVG|EPS|PDF]   #图像输出格式
    [-W| --watermark string ]          #加水印
 
数据与变量
定义数据获取方式：
  DEF：vname（变量名，只能包含数字和字母，最长不能超过255字符）=rrdfile（rrd文件路径）:ds-name（数据源名称）:CF（聚合函数）[:step=step][:start=time][:end=time]
  CDEF:vname=RPN expression
  VDEF:vname=RPN expression
 
图片
线状图：
   LINE[width（线条的粗细程度，1最细的3是最粗的）
   :value（上面定义的变量名称）[#color（线条颜色）]
   [:[legend（底面的标签名称）][:STACK]]
   [:dashes[=on_s[,off_s[,on_s,off_s]...]
   [:dash-offset=offset]
面积图：
    AREA：value[#color][:[legend][:STACK]]
```

## 样例

```
.\rrdtool.exe create test.rrd --step 60 DS:test:GAUGE:8:0:U RRA:LAST:0.5:1:3600
.\rrdtool.exe graph test.png --step 60 -t test DEF:vtest=test.rrd:test:LAST LINE1:vtest#FF0000:testline1 --font "DEFAULT:13:fonts\times.ttf"
```