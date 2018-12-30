---
title: JavaScript-ES5
date: 2018-11-16 20:04:03
categories:
- 语言
tags:
---
一个完整的JavaScript实现包含了三个部分：
1.核心(ECMAScript)
2.文档对象模型(DOM)
3.浏览器对象模型(BOM)

## 严格模式

ECMAScript 5引入了严格模式。在严格模式下ECMAScript 3的一些不确定的行为将得到处理，而且对某些不安全的操作也会抛出错误。
整个脚本中启动严格模式
```
"use strict";
```

在函数内启动严格模式
```
function doSomething(){
    "use strict";
}
```

## 变量

ECMAScript的变量是松散类型的，可以用来保存任何类型的数据。
```
var message;
```
ECMAScript变量可能包含两种不同数据类型的值：基本类型值和引用类型值。

## 数据类型

ECMAScript不支持任何创建自定义类型的机制，所有值都最终将是6种数据类型之一。
1. Undefined。Undefined类型只有一个值，即特殊的undefined。在使用var声明变量但未对其加以初始化时，这个变量的值就是Undefined。
```
var message;
alert(message == undefined); // true
```
2. Null
Null类型是第二个只有一个值的数据类型，这个特殊的值是null。从逻辑角度来看，null值表示一个空对象指针，而这也正是使用typeof操作符检测null值会返回"object"的原因。
```
var car = null;
alert(typeof car); // "object"
```
3. Boolean
该类型只有两个字面值：true和false。这两个值与数字值不是一回事，因此true不一定等于1，而false也不一定等于0。
4. Number
这种类型使用IEEE754格式来表示整数和浮点数值。
5. String
String类型用于表示由零或多个16位Unicode字符组成的字符序列。
6. Object
ECMAScript中的对象其实就是一组数据和功能的集合。对象可以通过执行new操作符后跟要创建的对象类型的名称来创建。

### typeof操作符

用来检测给定变量的数据类型。typeof操作符可能返回下列某个字符串。
- "undefined"-如果这个值未定义
- "boolean"-如果这个值是布尔值
- "string"-如果这个值是字符串
- "number"-如果这个值是数值
- "object"-如果这个值是对象或Null
- "function"-如果这个值是函数

typeof 操作符会返回一些令人迷惑但技术上却正确的值。比如，调用`typeof null`会返回`object`，因为特殊值`null`被认为是一个空的对象引用。

## 函数

ECMAScript中的函数使用function关键字来声明，后跟一组参数以及函数体。
```
function functionName(arg0, arg1, ..., argN){
    statements
}
```
严格模式对函数有一些限制：
- 不能把函数命名为eval或arguments;
- 不能把参数命名为eval或arguments;
- 不能出现两个命名参数同名的情况

ECMAScript中的参数在内部是用一个数组来表示的。即便你定义的函数只接收两个参数，在调用这个函数时也未必一定要传递两个参数。在函数体内可以通过arguments对象来访问这个参数数组，从而获取传递给函数的每一个参数。命名的参数只提供便利，但不是必须的。

### 没有重载
如果在ECMAScript中定义了两个名字相同的函数，则该名字只属于后定义的函数。

## 执行环节及作用域

执行环境定义了变量或函数有权访问的其他数据，决定了它们各自的行为。每个执行环境都有一个与之关联的变量对象，环境中定义的所有变量和函数都保存在这个对象中。虽然我们编写的代码无法访问这个对象，但解析器在处理数据时会在后台使用它。
全局执行环境是最外围的一个执行环境。在Web浏览器中，全局执行环境被认为是window对象。

## 闭包

闭包是指有权访问另一个函数作用域中的变量的函数。