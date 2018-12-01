---
title: List
date: 2018-10-14 12:31:22
categories:
- 数据结构
tags:
---

## MyArrayList 
MyArrayList将保持基础数组，数组的容量，以及存储在MyArrayList中的当前项数。

MyArrayList将提供一种机制以改变基础数组的容量。通过获得一个新数组，将老数组拷贝到新数组中来改变数组的容量，允许虚拟机回收老数组。

MyArrayList将提供get和set的实现。

MyArrayList将提供基本的例程，如size、isEmpty和clear。还提供remove，以及两种不同版本的add。如果数组的大小和容量相同，那么这两个add例程将增加容量。

MyArrayList将提供一个实现Iterator接口的类。这个类将存储迭代序列中的下一项的下表，并提供next、hasNext和remove等方法的实现。
 
```
public class MyArrayList<AnyType> implements Iterable<AnyType>
{
	private static final int DEFAULT_CAPACITY = 10;
	
	private int theSize;
	private AnyType[] theItems;
	
	public int size()
	{
		return theSize;
	}
	
	public boolean isEmpty()
	{
		return size() == 0;
	}
	
	//调整容量符合大小
	public void trimToSize()
	{
		ensureCapacity(size());
	}
	//确保数组大小足够大
	public void ensureCapacity(int newCapacity)
	{
		if(newCapacity < theSize)
			return;
		
		//复制数据到新数组中
		AnyType[] old = theItems;
		theItems = (AnyType[]) new Object[newCapacity];
		for(int i = 0; i <size(); i++)
		{
			theItems[i] = old[i];
		}
	}
	public AnyType get(int index)
	{
		if(index < 0 || index >= size())
		{
			throw new ArrayIndexOutOfBoundsException();
		}
		return theItems[index];
	}
	
	public AnyType set(int index, AnyType newVal)
	{
		if(index < 0 || index >= size())
		{
			throw new ArrayIndexOutOfBoundsException();
		}
		AnyType old = theItems[index];
		theItems[index] = newVal;
		return old;
	}
	
	public void add(int index, AnyType x)
	{
		//数组不够大，则扩大数组
		if(theItems.length == size())
		{
			ensureCapacity(size()*2 + 1);
		}
		//从index开始，元素往后移动一位
		for(int i = theSize; i > index; i--)
		{
			theItems[i] = theItems[i - 1];
		}
		//index位置赋值x
		theItems[index] = x;
		theSize++;
	}
	
	public AanyType remove(int index)
	{
		AnyType removedItem = theItems[index];
		for(int i = index; i < size(); i++)
		{
			//从index位置开始，所有元素都往前移动一位
			theItems[i] = theItems[i + 1];
		}
		theSize--;
		return removedItem;
	}
	
	public java.util.Iterator<AnyType> iterator()
	{
		return new ArrayListIterator<AnyType>();
	}
	
	private static class ArrayListIterator<AnyType> implements java.util.Iterator<AnyType>
	{
		private int current = 0;
		
		public boolean hasNext()
		{
			return current < MyArrayList.this.size();
		}
		
		public AnyType next()
		{
			return MyArrayList.this.theItems[current++];
		}
		
		public void remove()
		{
			//防止迭代器的remove与MyArrayList的remove冲突
			MyArrayList.this.remove(--current);
		}
	}
};
```

## MyLinkedList 
MyLinkedList类，包含两端的链、表的大小以及一些方法。

Node类，一个节点包含数据以及到前一个节点的链和到下一个节点的链，还有一些适当的构造方法。

LinkedListIterator类，该类抽象了位置的概念，并实现接口Iterator。它提供了方法next、hasNext和remove的实现



使用额外的头节点和尾节点的优点在于，通过排除许多特殊情形极大地简化了编码。例如，如果我不使用头节点，那么删除第1个节点就变成了一种特殊的情况，因为在删除期间我们必须重新调整链表到第1个节点的链。

```
public class MyLinkedList<AnyType> implements Iterable<AnyType>
{
	private static class Node<AnyType>
	{
		public AnyType data;
		public Node<AnyType> prev;
		public Node<AnyType> next;
		public Node(AnyType d, Node<AnyType> p, Node<AnyType> n)
		{
			data = d;
			prev = p;
			next = n;
		}
	}
	
	private int theSize;
	//自从链表构造以来对链表所做的改变次数
	//与迭代器里的modCount进行比较
	private int modCount = 0;
	//头节点
	private Node<AnyType> beginMarker;
	//尾节点
	private Node<AnyType> endMarker;
	
	public boolean add(AnyType x)
	{
		add(size(), x);
		return true;
	}
	
	public void add(int index, AnyType x)
	{
		//根据index获取节点，在该节点前添加x
		addBefore(getNode(index, x));
	}
	
	public void addBefore(Node<AnyType> p, AnyTyoe x)
	{
		//在p和p之前插入新节点
		Node<AnyType> newNode = new Node<AnyType>(x, p.prev, p);
		//更新新节点前一节点的后一节点链接
		newNode.prev.next = newNode;
		//更新p的前一节点链接
		p.prev = newNode;
		theSize++;
		modCount++;
	}
	public AnyType get(int index)
	{
		return getNode(index).data;
	}
	
	public AnyType set(int index, AnyType newVal)
	{
		Node<AnyType> p = getNode(index);
		AnyType oldVal = p.data;
		p.data = newVal;
		return oldVal;
	}
	
	public AnyType remove(int index)
	{
		return remove(getNode(index));
	}
	
	private AnyType remove(Node<AnyType> p)
	{
		p.next.prev = p.prev;
		p.prev.next = p.next;
		theSize--;
		modCount++;
		
		return p.data;
	}
	
	private Node<AnyType> getNode(int index)
	{
		Node<AnyType> p;
		
		if(index < 0 || index > size())
		{
			throw new IndexOutOfBoundsException();
		}
		
		//从头节点或者尾节点开始查找
		if(index < size() / 2)
		{
			p = beginMarker.next;
			for(int i = 0; i < index; i++)
			{
				p = p.next;
			}
		}
		else
		{
			p = endMarker;
			for(int i = size(); i > index; i--)
			{
				p = p.prev;
			}
		}
		
		return p;
	}
	
	private class LinkedListIterator implements java.util.Iterator<AnyType>
	{
		private Node<AnyType> current = beginMarker.next;
		private int expectedModCount = modCount;
		private boolean okToRemove = false;
		
		public boolean hasNext()
		{
			return current != endMarker;
		}
		
		public AnyType next()
		{
			if(modCount != expectedModCount)
			{
				throw new java.util.ConcurrentModificationException();
			}
			if(!hasNext())
			{
				throw new java.util.NoSuchElementException();
			}
			
			AnyType nextItem = current.data;
			current = current.next;
			okToRemove = true;
			return nextItem;
		}
		
		public void remove()
		{
			if(modCount != expectedModCount)
			{
				throw new java.util.ConcurrentModificationException();
			}
			if(!okToRemove)
			{
				throw new IllegalStateException();
			}
			
			MyLinkedList.this.remove(current.prev);
			okToRemove = false;
			expectedModCount++;
		}
	}
}
```