---
title: AvlTree
date: 2018-10-14 12:33:05
categories:
- 数据结构
tags:
---

AVL树使带有平衡条件的二叉查找树。

一棵AVL树是其每个节点的左子树和右子树的高度最多差1的二叉查找树(空树的高度定为-1)。

当进行插入操作时，我们需要更新通向根节点路径上那些节点的平衡信息，而插入操作的隐含着困难的原因在于，插入一个节点可能破坏AVL树的特性。如果发生这种情况，那么就要考虑这一步插入完成之前恢复平衡的性质。事实上，这总可以通过对树进行简单的修正来做到，我们称其为旋转。

第一种情况是插入发生在“外边"的情况（即左子树-左儿子或右子树-右儿子），该情况通过对树的一次单旋转而完成调整。

第二种情况是插入发生在"内部"的情况（即左子树-右儿子或右子树-左儿子），该情况通过稍微复杂些的双旋转来处理。

1. 单旋转  
```
private AvlNode<AnyType> rotateWithLeftChild(AvlNode<AnyType> k2)
{
    AvlNode<AnyType> k1 = k2.left;
    k2.left = k1.right;
    k1.right = k2;
    k2.height = Math.max(height(k2.left), height(k2.right)) + 1;
    k1.height = Math.max(height(k1.left), k2.height) + 1;
    return k1;
}
```

2. 双旋转  
```
private AvlNode<AnyType> doubleWithLeftChild(AvlNode<AnyType> k3)
	{
		k3.left = rotateWithLeftChild(k3.left);
		return rotateWithLeftChild(k3);
	}

```