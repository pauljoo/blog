---
title: FAQ-如何解决VC中的警告Warning-C4251
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
---

转载自:http://wwywnp.blog.163.com/blog/static/16372208720112109039559/

这通常是由于以数据成员方式在DLL导出类中使用了模板类造成的。比如：
#include <iostream>
#include <vector>
using namespace std;

class __declspec( dllexport ) Test
{
public:
std::vector<int> m_objCon;
};

int main()
{



return 0;
}

这会导致这个警告:
warning C4251: “Test::m_objCon”: class“std::vector<_Ty>”需要有 dll 接口由 class“Test”的客户端使用 
1>        with
1>        [
1>            _Ty=int
1>        ]
这个问题主要要描述的是不同的地方的vector的实现可能不一样所造成的问题。所以我们应该将其导出。有很多方法可以解决这个问题的。

第一种： 无视它或者#pragma warnind( disable: 4251 )
第二种：将该数据改为指针方式：
class __declspec( dllexport ) Test
{
public:
std::vector<int>* m_objCon;
};
然后在构造函数和析构函数中分别初始化和释放它。
第三种：
将该模板类及其依赖类导出。
#include <iostream>
#include <vector>
using namespace std;

class __declspec( dllexport ) Test
{
public:
template  class __declspec( dllexport ) std::allocator<int>;
template  class __declspec( dllexport ) std::vector<int, std::allocator<int> >;
public:

std::vector<int> m_objCon;
};

int main()
{



return 0;
}
这种方法要注意的是必须要把要导出模板类的模板数据成员一并导出。有点类似于显式实例化。比如说你要导出boost::shared_ptr就还必须将其依赖的shared_count一并导出。导出map还需要导出对应pair等等。很麻烦啦~所以我们还是选择第四种吧。

第四种：Impl。
#include <iostream>
#include <vector>
using namespace std;

// 这些放到.h中
class Test_imp;
class __declspec( dllexport ) Test
{
// 构造函数中初始化 析构中释放m_pImp;
void test();
public:
Test_imp* m_pImp;
};

// 这个类放到cpp中去
class  Test_imp
{
public:
void test(){}
std::vector<int> m_objCon;
};

// 放到cpp中
void Test::test()
{
m_pImp->test();
}

int main()
{



return 0;
}

个人推荐第二种和第四种，反对第一种。毕竟掩耳盗铃不是好习惯~~
第四种除了可以解决上面的问题之外还可以隐藏代码，当然多了一个桥接的过程。



程序中消除warning有两种方法：消极一点不去理他，反正不是error:-)；积极一点，则想办法去掉。去掉又用两种方法：一种使用#pragma warning(disable: xxxx)，眼不见，心不烦；另外就是找出解决问题的办法了。
今天做dll库时，在struct中用到了stl：
class CLASS_TEST
{
    …
private:
    std::vector<MY_STRUCT> m_structs;
}
但是编译时，vs2005给出了warning C4251: ‘CLASS_TEST::m_structs’ : class ‘std::vector<_Ty>’ needs to have dll-interface to be used by clients of class ‘CLASS_TEST’的警告信息。费了很大的劲才解决掉，记录下来。

在头文件中，定义宏
#ifdef MYDLL_EXPORTS
#define MYDLL_API __declspec(dllexport)
#else
#define MYDLL_API __declspec(dllimport)
#endif

现在，在变量m_structs前，添加：
template class MYDLL_API std::allocator<myStruct>;
template class MYDLL_API std::vector<myStruct, std::allocator<myStruct> >;
这样，即可以了。



另一篇:

1:情况一
如果类的定义里面仅含有 编译器内置的类型变量, int, float 等等. 或者成员函数仅使用了这些变量作为参数, 那么很简单.
直接
class __declspec(dllexport) YourClass

{
}
就行了.

2:情况二
如果类内部使用了别的类, 那么别的类最好也导出, 不然, 首先编译的时候会出现编译警告:
warning C4251: needs to have dll-interface 
意思是,你使用另外的一些类型/接口, 但是这些类型或接口没有导出. 当你的client使用这些类型/接口的时候, 会出错!
class __declspec(dllexport) YourClass

{
   YourAnatherClass m_data; // 这里会 出现 warning 4251. 如果YourAnatherClass 没有导出的话.
}
解决办法就是: 在YourAnatherClass定义的地方加上
class __declspec(dllexport) YourAnatherClass 
{
}
如上, 当你的YourAnatherClass没有导出的时候, dll的使用方会出现链接错误

3:情况三
当类的内部使用了STL模板的时候, 也会出现C4251警告, 情况会有所不同
class __declspec(dllexport) YourClass

{
   vector<int> m_data; // 这里会 出现 warning 4251. 因为vector<int>类型没有被导出
}
上面的使用模板(无论是stl模板,还是自定义模板)的代码,编译dll时会出现C4251警告, 但是dll的使用方, 却不会出现链接错误!!!
这个因为, dll的使用方那里也有一套模板的定义, 当他们使用那个vector<int>的时候, 虽没有导出, 但是用户自己也有一套STL模板(或者是自定义的模板),用户会利用自己的模板实例化这个dll中没有导出的东西!

所以, 对于因为使用STL(或模板)出现的c4251警告, 关闭之即可
#pragma warning(push)
#pragma warning(disable:4251)
//your declarations that cause 4251
#pragma warning(pop)

若想不使用通过关闭警告的方式关闭警告, 那么就这样
1)对于用户自定义的模板
   template class DLLImportExportMacro SomeTemplate<int>;
   SomeTemplate<int> y;
2)对于STL的模板
     template class DLLImportExportMacro std::allocator<int>
     template class DLLImportExportMacro std::vector<int,
      std::allocator<int> >;
     vector<int> m_data;


