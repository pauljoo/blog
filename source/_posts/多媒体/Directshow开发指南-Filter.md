---
title: Directshow开发指南-Filter
date: 2018-11-18 16:55:58
categories:
- 多媒体
tags:
---
Filter是Directshow中最基本的概念。Directshow使用FilterGraph来管理Filter。

Filter一般由一个或多个Pin组成，Filter之间通过Pin相互连接，构成一条顺序的链路。Filter根据实现功能的不同大致可分为3类：source filters、transform filters和rendering filters。

 

Filter是一种Com组将。每个Filter实现了IBaseFilter接口。

Filter通过API函数CoCreateInstance完成。

Filter使用媒体类型(Media Type)来描述数据流
```
Typedefstruct _MediaType{
GUID Majortype;
GUID Subtype;
BOOL bFixedSizeSamples;
BOOL bTemporalCompression;
ULONG lSampleSize;
GUID Formattype;
Iunknown *pUnk;
ULONG cbFormat;
BYTE *pbFormat;
}AM_MEDIA_TYPE;
```
媒体类型主要用3部分来描述：majortype(主类型)、subtype(辅助说明类型)和formattype(格式细节类型)

Majortype:定性的描述媒体类型，比如MEDIATYPE_Video,MEDIATYPE_Audio等

Subtype:辅助说明majortype，指明具体是哪种格式，例如，UYVY、YUY2

Formattype:指定了一种进一步描述格式细节的数据结构类型，包括视频图像大小、帧率，这个描述格式细节的数据块指针保存在pbFormat成员中。

 

Filter的连接：

1.Filter GraphManager在输出Pin上调用Ipin::Connect(带输入Pin的指针作为参数);

2.如果输出Pin接受连接，则调用输入Pin上的Ipin::ReceiveConnection;

3.如果输入Pin也接受这次连接，则双方连接成功。

 

Filter的Merit值，Merit可以理解成为Filter被智能连接所使用的优先级。
```
Enum
{
MERIT_PREFERRED
MERIT_NORMAL
MERIT_UNLIKELY
MERIT_DO_NOT_USE
MERIT_SW_COMPRESSOR
MERIT_HW_COMPRESSOR
};
```
Merit值只有在大于MERIT_DO_NOT_USE的时候，才有可能被智能连接所使用