---
title: 面向模式的软件架构-Layers模式
date: 2018-11-16 20:04:09
categories:
- 系统架构和设计
tags:
- 面向模式的软件架构
---
>Layers有助于将应用程序划分为多组子任务，其中每组子任务都位于特定抽象层。

## 背景
需要分解的大型系统

## 问题
假设你要设计一个系统，其主要特征是需要同时解决高层问题和低层问题，且高层操作依赖于低层操作。在这个系统中，有些部分负责处理低层问题，如硬件陷阱、传感器输入等。在另一端可能有用户可见的功能(如游戏的界面)或高层策略(如电话计费)。在典型的通信过程中，请求从高层向低层传输，而响应、到来的数据及事件通知沿相反的方向传输。

---
在这种情况下，需要平衡下述作用力。
1. 以后修改源代码不会波及整个系统。
2. 接口稳定，甚至遵守标准组织制定的标准。
3. 系统的各个部分都可更换。
4. 未来可能需要打造其他系统，这些系统与当前设计的系统面临着相同的低层问题。
5. 应将类似的职责编组，让系统更容易理解和维护。
6. 根本没有所有的标准组件粒度。
7. 复杂的组件需要进一步分解。
8. 跨越组件边界可能影响性能，例如，必须跨越多个组件边界传输大量数据时。
9. 系统将由一个程序员团队打造，因此分工必须明确。

## 结构
在结构方面，Layers模式的主要特征是，第J+1层只使用第J层的服务，层之间没有其他直接依赖关系。这种结构类似于栈，每层都将下面的各层保护起来，禁止上面的层直接访问它们。
|客户端|
|-|
|第N层|
|第N-1层|
|...|
|第1层|

## 实现
1. 定义将任务划分到不同层的抽象准则。该准则通常是离平台的概念距离。
在真正的软件开发中，大家通常结合使用多种抽象准则。例如，根据离硬件的距离划分较低的层，按概念复杂度划分较高的层。
例如，
||
|--|
|用户可以看到的元素|
|具体的应用程序模块|
|通用服务层|
|操作系统接口层|
|操作系统|
|硬件|

2. 根据抽象准则确定抽象层级数。层数太多可能带来不必要的开销，层数太少又可能导致结构不清晰。
3. 给每层命名并分派任务。最高层的任务就是整个系统要完成的任务，由客户指定。其他各层的任务是辅佐上一层。
4. 规范服务。最重要的实现原则是相邻界限分明，即任何组件都不跨越多层。
5. 完善层次划分。反复执行第1～4步。如果不考虑抽象准则导致的层及其服务，通常无法准确地定义抽象准则。另外，先定义组件和服务，再根据它们之间的使用关系拼凑出分层结构的做法通常是错误的。由于这样的结构没有反映固有的分层原则，维护系统时很可能破坏原有的架构。例如，新组件可能使用多层提供的服务，违背严格分层的策略。
解决之道是反复执行前4步，直到分层结构自然而稳定。
6. 规范每层的接口。如果对第J+1层来说，第J层应该算是“黑盒”，就应设计一个统一接口，该接口提供第J层的所有服务，还可能将其封装到一个Facade对象中。
7. 确定各层的结构。传统上，重点是确保层间关系合理，而各层内部却随心所欲，其结果是混乱不堪。对于复杂的层，应将其划分为多个组件，进行这种划分时粒度更细的模式可提供帮助。
8. 规范相邻层之间的通信。在层间通信方面，最常用的机制是推模型:第J层调用第J-1层的服务时，随服务调用一起传递所需的信息。与这种模型相反的是拉模型，指的是下层根据自己的判断从上层那取回信息。然而，拉模型可能增加当前层对上一层的依赖关系，要避免拉模型导致的下层对上层的依赖，可使用回调。
9. 将相邻层解耦。通常上一层知道下一层，但下一层不知道其用户的身份。这意味着只存在单向耦合:修改第J层时，不用考虑第J+1层，条件是被修改的服务的接口和语义保持不变。
为支持自下而上的通信，可使用回调，并保留自上而下的单向耦合。使用回调时，上层向下层注册回调函数。在下层向上层发送的事件固定时，这种方式特别有效。
还可在一定程度上降低上层对下层的依赖，根据接口编写上层的代码，让上层不依赖于下层的具体实现。**这里由主程序负责在层之间建立“连接”，但这种工作通常由连接管理组件统一管理。**
对于需要同时向上和向下传递消息的通信栈，显示地将下层关联到上层通常更佳。
10. 制定错误处理策略。对分层架构而言，处理错误的代价可能非常高，无论从处理时间还是编程工作量的角度来说都如此。错误发生后，要么在当前层进行处理，要么转给上一层。如果采用第二种做法，当前层必须将错误转换为上一层能够明白的错误描述。**一般说来，应尽可能在当前层处理错误，以免高层包含大量处理众多不同错误的代码。**

## 效果
优点
1. 各层可重用
2. 支持标准化。一个著名的标准化接口是POSIX编程接口。
3. 限制了依赖关系的范围。
4. 可更换性。
缺点
1. 行为变化可能引发雪崩效应。一层的行为发生变化可能引发严重的问题。如果为完成局部调整，必须对很多层做大量修改，那么分层就成了缺点。
2. 效率低下。
3. 不必要的工作。
4. 难以确定正确的层次粒度。