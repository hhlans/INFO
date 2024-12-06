`2023-05-22`

[CSDN博客](https://blog.csdn.net/qq_66664177/article/details/130826563)，虽然浏览至今还没过百。

---

# 反向传播算法迭代参数公式的推导
## 1 前言 
  
在斯坦福大学吴恩达教授的机器学习的课程中，由于课时或者别的原因其对于反向传播算法的公式的推倒没有很详细，于是手动推导并写篇博客记录一下

在公式的推导过程中可能没有对矩阵转置并且没有考虑正则化 角标有时用得不是很严谨 可能会存在一些错误
 
## 2 正文


### 2.1 结论
在公式推导之前先写结论

反向传播算法的cost function

$$\begin{aligned} J(\theta)= & \frac{1}{m} \sum_{i=1}^m \sum_{k=1}^K\left[-y_k^{(i)} \log \left(\left(h_\theta\left(x^{(i)}\right)\right)_k\right)-\left(1-y_k^{(i)}\right) \log \left(1-\left(h_\theta\left(x^{(i)}\right)\right)_k\right)\right]\end{aligned}$$

对于神经网络的参数更新有 

$$\begin{aligned} \Theta^{l} = & \Theta^{l} - \alpha \frac{\partial }{\partial \Theta^l}J \left( \Theta \right) \end{aligned}$$

反向传播算法从神经网络的输出层到输入层更新参数

$$\begin{aligned}  \frac{\partial }{\partial \Theta^l}J \left( \Theta \right) &= a^l \delta^{l+1}\\
\delta^{l} &= \Theta^{l} \delta^{l+1} g'\left(z^{l}\right) \\
\delta^n &= \left(y-a^n\right)
\end{aligned}$$


### 2.2 公式推导
假设训练集 

$$\begin{aligned} \left(x, y \right)=& \left\{ \left(x_1, y_1\right) \left(x_2, y_2\right) \left(x_3, y_3\right)...\left(x_n, y_n\right)\right\}  \end{aligned}$$  
 
对cost function， 对给定的$\alpha$,注意到$J(\Theta)$对$\Theta^l$的影响是从最后一层往前的，所以  

$$\begin{aligned} \frac{\partial }{\partial \Theta^l}J \left( \Theta \right) = &\frac{\partial J\left(\Theta\right)}{\partial a^{n}} \frac{\partial a^n}{\partial a^{n-1}}......\frac{\partial a^{l+2}}{\partial a^{l+1}} \frac{\partial a^{l+1}}{\partial \Theta^l}\end{aligned}$$   

该公式可以分成三部分

$$\begin{aligned} \frac{\partial J\left(\Theta\right)}{\partial a^{n}}\space\space\space \frac{\partial a^i}{\partial a^{i-1} } \space\space\space \frac{\partial a^{l+1}}{\partial \Theta^l} \end{aligned}$$   

其实从中就能发现迭代的规律了，忽略最后一项  

$$\frac{\partial a^{l+1}}{\partial \Theta^l}$$

令

$$\begin{aligned}P^i &= \frac{\partial J\left(\Theta\right)}{\partial a^{n}} \frac{\partial a^n}{\partial a^{n-1}}...\frac{\partial a^i}{\partial a^{i-1}}\\
P^i &= P^{i+1}\frac{\partial a^i}{\partial a^{i-1}}\\
P^n &= \frac{\partial J\left(\Theta\right)}{\partial a^{n}}\frac{\partial a^n}{\partial a^{n-1}}\end{aligned}$$

所以

$$\begin{aligned} \frac{\partial }{\partial \Theta^l}J \left( \Theta \right) = P^l  \frac{\partial a^{l+1}}{\partial \Theta^l} \end{aligned}$$

**第一部分**  
$a^n$其实就是$h_\Theta (x)$  

$$\begin{aligned} J\left(\Theta\right) &= -\frac{1}{m}\left(y\log(a^n)+\left(1-y\right)\left(\log\left(1-a^n\right)\right)\right)\\
\frac{\partial J\left(\Theta\right)}{\partial a^{n}} &= -\frac{1}{m}\left( \frac{y}{a^n}-\frac{1-y}{1-a^n}\right)\\&=-\frac{1}{m}\frac{y-a^n}{a^n\left(1-a^n\right)} \end{aligned}$$

**第二部分**  
注意到$a^i$先影响到$z^i$，再影响到$a^{i-1}$，并且

$$g'\left(x\right) = g\left(x\right)\left(1-g\left(x\right)\right)$$

$$\begin{aligned} \frac{\partial a^{i}}{\partial a^{i-1}} &=  \frac{\partial a^{i}}{\partial z^{i}} \frac{\partial z^{i}}{\partial a^{i-1}} \\& =g'\left(z^i \right)\Theta^{i-1}\\&=a^i\left(1-a^i\right)\Theta^{i-1}\end{aligned}$$

**第三部分**
$\begin{aligned} \frac{\partial a^{l+1}}{\partial \Theta^l}& = a^l\end{aligned}$

**综合**

$$\begin{aligned} P^n &= \frac{\partial J\left(\Theta\right)}{\partial a^{n}}\frac{\partial a^n}{\partial a^{n-1}} \\& =-\frac{1}{m}\frac{y-a^n}{a^n\left(1-a^n\right)}a^n\left(1-a^n\right)\Theta^{n-1} \\ &= -\frac{1}{m}\left(y-a^n\right)\Theta^{n-1}\end{aligned}$$ 

$$\begin{aligned} &P^i = P^{i+1}g'(z^{i+1})\Theta^{i} \\&\frac{\partial }{\partial \Theta^l}J \left( \Theta \right) = P^i\end{aligned}$$  

令

$$\begin{aligned} & \delta^n=a^n-y\\& \delta^{i} = \delta^{i+1}\Theta ^{i} g'(z^{i+1}) \\& P^i = \delta^i \Theta^l \frac{\partial a^{l+1}}{\partial \Theta^l}=\delta^ia^i\end{aligned}$$  

则

$$\begin{aligned} \frac{\partial }{\partial \Theta^l}J \left( \Theta \right) = \frac{1}{m}\delta^{l+1} a^l \end{aligned}$$

