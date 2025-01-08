`2025-01-08`

---

## 前置知识
### 多变量泰勒展开
一元函数泰勒展开

$$\begin{aligned}f(x)=f(x_0)+f'(x_0)(x-x_0)+f''(x_0)+o^n\end{aligned}$$

二元函数泰勒展开

$$\begin{aligned}f(x, y)=&f(x_0,y_0)+\\&(x-x_0)f'_x(x_0, y_0)+(y-y_0)f'_y(x_0, y_0)+\\&\frac{1}{2!}(x-x_0)^2f''_{xx}(x_0, y_0)+\frac{1}{2!}(x-x_0)(y-y_0)f''_{xy}(x_0,y_0)+\\&\frac{1}{2!}(x-x_0)(y-y_0)f''_{xy}(x_0,y_0)+\frac{1}{2!}(y-y_0)^2f''_{yy}(x_0,y_0)+o^n\end{aligned}$$

多元函数泰勒展开

$$\begin{aligned}f(x^1, x^2,...,x^n)=&f(x_0^1,x_0^2,...,x_0^3)+\\&\sum_{i=1}^{n}(x^i-x_0^i)f'_i(x_0^1,x_0^2,...,x_0^n)+\\&\sum_{i=1}^{n}\bigg[\sum_{j=1}^{n}(x^i-x_0^j)(x^j-x_0^j)f''_{ij}(x_0^1, x_0^2,...,x_0^n)\bigg]+o^n\end{aligned}$$

写成矩阵形式有

$$\begin{aligned}&f([x^1,x^2,...,x^n]^T)\\=&f(X)\\=&f(X_0)+[\nabla f(X_0)]^T(X-X_0)+\frac{1}{2!}(X-X_0)^TH(X_0)(X-X_0)\end{aligned}$$

其中

$$H(X_0)=\left[
\begin{matrix}
\frac{\partial^2f}{\partial X_1^2} &\frac{\partial^2f}{\partial X_1\partial X_2} &\cdots & \frac{\partial^2f}{\partial X_1\partial X_n}\\
\frac{\partial^2f}{\partial X_2\partial X_1}&\frac{\partial^2f}{\partial X_2^2}  &\cdots & \frac{\partial^2f}{\partial X_2\partial X_n}\\
\vdots&\vdots&\ddots&\vdots\\
\frac{\partial^2f}{\partial X_n\partial X_1}&
\frac{\partial^2f}{\partial X_n\partial X_2}&
\cdots &
\frac{\partial^2f}{\partial X_n^2} 
\end{matrix} 
\right]
$$

## 泛函与变分基础
设函数集 $\{y(x)\}$，对集合中的任一一个函数恒有某个确定的值 $\Pi\big[y(x)\big]$ 与之对应，则称$\Pi\big[y(x)\big]$ 是定义在集合 $\{y(x)\}$ 的一个泛函。

例如：

$$T\big[y(x)\big]=\int_a^b\sqrt{\frac{1+(y')^2}{2gy}}dx$$

微分

$$dy=y(x+dx)-y(x)$$

变分

$$\delta\Pi\big[y(x)\big]=\Pi\big[y(x)+\delta y(x)\big]-\Pi\big[y(x)\big]$$

## 简单泛函极值问题-泛函的欧拉方程
### 泛函的欧拉-拉格朗日方程

$$\frac{\partial F}{\partial y}-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'}\bigg]=0$$

### 推导过程
泛函

$$J[y]=\int_a^bF\big(x,y,y')dx$$

设以无穷小量 $\varepsilon$ 和 一个足够光滑的函数$\eta(x)$，且满足$\eta(a)=0,\eta(b)=0$。

$$J[y+\varepsilon\eta]=\int_a^bF\big(x,y+\varepsilon\eta,y'+\varepsilon\eta')dx$$

$F\big(x,y+\varepsilon\eta,y+\varepsilon\eta')$多变量一阶泰勒展开

$$F\big(x,y+\varepsilon\eta,y'+\varepsilon\eta')=F\big(x,y,y')+\frac{\partial F}{\partial y}\varepsilon \eta+\frac{\partial F}{\partial y'}\varepsilon \eta'$$

故

$$\begin{aligned}\Delta J=&\int_a^b\frac{\partial F}{\partial y}\varepsilon \eta+\frac{\partial F}{\partial y'}\varepsilon \eta'dx\\=&\varepsilon\int_a^b\frac{\partial F}{\partial y} \eta+\frac{\partial F}{\partial y'} \eta'dx\end{aligned}$$

分部积分

$$\begin{aligned}\int_a^b\frac{\partial F}{\partial y'} \eta'dx=\frac{\partial F}{\partial y'}\eta\bigg|_a^b-\int_a^b \eta d\frac{\partial F}{\partial y'}\end{aligned}$$

由于$\eta(a)=0,\eta(b)=0$

$$\begin{aligned}\int_a^b\frac{\partial F}{\partial y'} \eta'dx=-\int_a^b\eta d\frac{\partial F}{\partial y'} \end{aligned}$$

综上

$$\begin{aligned}\Delta J=&\varepsilon\int_a^b\frac{\partial F}{\partial y} \eta-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'}\bigg]  \eta dx\\=&\varepsilon\int_a^b\frac{\partial F}{\partial y} \eta-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'} \bigg]\eta dx\end{aligned}$$

用变分表示

$$\begin{aligned}\delta J=&\varepsilon\int_a^b\frac{\partial F}{\partial y} \eta-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'}  \bigg]\eta dx\\=&\varepsilon\int_a^b \Bigg[\frac{\partial F}{\partial y}-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'} \bigg] \Bigg]\eta dx\end{aligned}$$

得到泛函的欧拉-拉格朗日方程

$$\frac{\partial F}{\partial y}-\frac{d}{dx}\bigg[\frac{\partial F}{\partial y'}\bigg]=0$$



