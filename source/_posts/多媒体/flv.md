---
title: FLV格式解析
date: 2018-11-18 16:56:57
categories:
- 多媒体
tags:
---
FLV文件由FLV Header和FLV Body组成

1  FLV Header  
|字段|	类型|	备注|
|-|-|-|
|标签|	UI8,1字节|	F,0x46|
|标签|	UI8,1字节|	L,0x4C|
|标签|	UI8,1字节|	V,0x56|
|版本号|	UI8,1字节|	文件版本(目前版本是1)|
|预留标记|	UB[5],5bit|	必须是0|
|音频标记|	UB[1],1bit|	是否存在音频|
|预留标记|	UB[1],1bit|	必须是0|
|视频标记|	UB[1],1bit|	是否存在视频|
|数据偏移|	UI32,4字节|	从文件开始到文件body的偏移(文件头的大小)|

2  FLV Body  
|字段|	类型|	备注|
|-|-|-|
|PreviousTagSize0|	UI32,4字节|	0|
|Tag1|	FLVTAG|	第1个tag|
|PreviousTagSize1|	UI32,4字节|	第1个tag大小(tag header+tag body)|
|Tag2|	FLVTAG|	第2个tag|
|...|||
|PreviousTagSizeN-1|	UI32,4字节|	第N-1个tag大小|
|TagN|	FLVTAG|	第N个tag|
|PreviousTagSizeN|	UI32,4字节|	第N个tag大小|

3  FLV Tags  
|字段|	类型|	备注|
|-|-|-|
|tag类型|	UI8|	8:音频 9:视频 18:脚本数据 其他为保留|
|数据大小|	UI24|	数据区大小|
|时间戳|	UI24|	毫秒为单位，第一个tag为0|
|扩展时间戳|	UI8|	放在高8位，前面的时间戳在低24位|
|StreamID|	UI24|	一直是0|
|数据	|tag 类型 ==  8,AUDIODATA TAG TYPE ==9,VIDEODATA TAG TYPE ==18 SCRIPTDATAOBJECT|	tag body