---
title: Markdown-数学公式
date: 2018-12-30 16:55:58
categories:
- 其他
tags:
mathjax: true
---

## 基本语法

行内显示`$...$`定义

单独显示`$$...$$`定义

语句为`$$\sum_{i=0}^N\int_{a}^{b}g(t,i)\text{d}t$$`

{% raw %}
$$\sum_{i=0}^N\int_{a}^{b}g(t,i)\text{d}t$$
<script src="http://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({text2jax: {inlineMath: [['$','$'], ['\\(', '\\)']]}});
</script>
{% endraw %}


## 希腊字母

- 若需要大写希腊字母，将命令首字母大写即可。
- 若需要斜体希腊字母，将命令前加上var前缀即可。

|显示|	命令|	显示|	命令|
|-|-|-|-|
|α	|\alpha	|β	|\beta
|γ	|\gamma	|δ	|\delta
|ε	|\epsilon	|ζ	|\zeta
|η	|\eta	|θ	|\theta
|ι	|\iota	|κ	|\kappa
|λ	|\lambda	|μ	|\mu
|ν	|\nu	|ξ	|\xi
|π	|\pi	|ρ	|\rho
|σ	|\sigma	|τ	|\tau
|υ	|\upsilon	|φ	|\phi
|χ	|\chi	|ψ	|\psi
|ω	|\omega|||