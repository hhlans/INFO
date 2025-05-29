# 一维非稳态扩散有限体积法

## 1. INTRODUCE

以一维非稳态热传导为例，取薄层控制体作热量衡算有 

$$\begin{align}
&\rho c\cdot \Delta V\cdot\frac{\partial T}{\partial t}=A\cdot\Big[(-k\frac{\partial T}{\partial x})_{x}-(-k\frac{\partial T}{\partial x})_{x+\Delta x}\Big]+\Delta V\cdot S\\
\Longrightarrow~~&\rho c\frac{\partial T}{\partial t}=\frac{\partial}{\partial x}\Big(-k\frac{\partial T}{\partial x}\Big)+S
\end{align}\tag{1}$$

## 2. 方程离散

 $t$ 到 $t+\Delta t$ 时间内，对控制体积分有

$$
\int_{t}^{t+\Delta t}\int_{\Delta V}\rho c\frac{\partial T}{\partial t}\mathrm{d}V\mathrm{d}t=
\int_{t}^{t+\Delta t}\int_{\Delta V}\frac{\partial}{\partial x}\Big(k\frac{\partial T}{\partial x}\Big)\mathrm{d}V\mathrm{d}t+
\int_{t}^{t+\Delta t}\int_{\Delta V}S\mathrm{d}V\mathrm{d}t\tag{2}
$$

高斯散度定理

$$
\int_{\Delta V}\mathrm{d}V\int_{t}^{t+\Delta t}\rho c\frac{\partial T}{\partial t}\mathrm{d}t=
\int_{t}^{t+\Delta t}\int_{A}\mathbf{n\cdot}\frac{\partial}{\partial x}\Big(k\frac{\partial T}{\partial x}\Big)\mathrm{d}A\mathrm{d}t+
\int_{t}^{t+\Delta t}\int_{\Delta V}S\mathrm{d}V\mathrm{d}t\tag{3}
$$

线性差值近似温度和源项

$$
\int_{\Delta V}\mathrm{d}V\int_{t}^{t+\Delta t}\rho c\frac{\partial T}{\partial t}\mathrm{d}t=
\int_{t}^{t+\Delta t}\Big[(kA\frac{\partial T}{\partial x})_e-(kA\frac{\partial T}{\partial x})_w\Big]\mathrm{d}t+
\int_{t}^{t+\Delta t}\overline{S}\Delta V\mathrm{d}t\tag{4}
$$

式（4）左端近似

$$\int_{\Delta V}\mathrm{d}V\int_{t}^{t+\Delta t}\rho c\frac{\partial T}{\partial t}\mathrm{d}t\approx
\int_{\Delta V}\mathrm{d}V\int_{t}^{t+\Delta t}\rho c\frac{T_P-T_P^0}{\Delta t}\mathrm{d}t=
\rho c(T_P-T_P^0)\Delta V
\tag{5}$$

式（5）结合式（4）有

$$\rho c(T_P-T_P^0)\Delta V=
\int_{t}^{t+\Delta t}\Big[k_eA_e\frac{T_P-T_W}{\delta x_{PE}}-k_wA_w\frac{T_E-T_P}{\delta x_{WP}}\Big]\mathrm{d}t+
\overline{S}\Delta V\Delta t
\tag{6}$$

为近似扩散项时间积分，通常采用 $T_P$ 和 $T_P^0$ 的加权组合近似 $\Delta t$ 时间内的平均温度，即

$$\overline{T_P}=\theta T_P+(1-\theta)T_P^0\tag{7}$$

所以有

$$I_T=\int_t^{t+\Delta t}T_P~\mathrm{d}t=\big[\theta T+(1-\theta)T_P^0\big]\Delta t\tag{8}$$

对 $T_E、T_P、T_W$ 使用式（8）代入（6）有

$$\begin{align}
\rho \frac{c(T_P-T_P^0)}{\Delta t}\Delta x=\theta\Big[\frac{k_e(T_E-T_P)}{\delta x_{PE}}-\frac{k_w(T_P-T_W)}{\delta x_{WP}}\Big]\\
+(1-\theta)\Big[\frac{k_e(T_E^0-T_P^0)}{\delta x_{PE}}-\frac{k_w(T_P^0-T_W^0)}{\delta x_{WP}}\Big]
+\overline{S}\Delta x
\end{align}\tag{9}$$

按节点温度整理

$$\begin{align}
\Big[\rho c\frac{\Delta x}{\Delta t}+\theta(\frac{k_e}{\delta x_{PE}}-\frac{k_w}{\delta x_{WP}})\Big]T_P=
\frac{k_e}{\delta x_{PE}}\Big[\theta T_E+(1-\theta)T_E^0\Big]+\\
\frac{k_w}{\delta x_{WP}}\Big[\theta T_W+(1-\theta)T_W^0\Big]+
\Big[\rho c\frac{\Delta x}{\Delta t}-(1-\theta)\frac{k_w}{\delta x_{WP}}\Big]T_P^0+\overline{S}\Delta x
\end{align}\tag{10}$$

将节点温度系数归一化

$$\begin{align}a_PT_p=a_W\Big[\theta T_W+(1-\theta)T_W^0\Big]+a_E\Big[\theta T_E+(1-\theta)T_E^0\Big]\\
+\Big[a_p^0-(1-\theta)a_w-(1- \theta)a_E\Big]T_P^0+b
\end{align}\tag{11}$$

其中

$$\begin{align}
a_W=\frac{k_w}{\delta x_{WP}}~,~a_E=\frac{k_e}{\delta x_{PE}}~,~a_P^0=\rho c\frac{\Delta x}{\Delta t}~,\\
a_p=\theta(a_W+a_E)+a_P^0~,~b=\overline{S}\Delta x
\end{align}$$

离散方程的具体形式可以根据加权因子 $\theta$ 分成三类

1. $\theta =0$ ，显式计算格式
2. $0<\theta \leqslant 1$ ，隐式计算格式，当 $\theta =1$ 时称全隐式计算格式
3. $\theta =0.5$ ，Crank-Nicolson（C-N）格式

对各种计算格式的有界性和精度暂不具体展开。

## 示例 1. 无内热源-一维非稳态热传导问题

!!! question 
    无限大薄板，初始均匀温度 $200\mathrm{^o C}$，在某一时刻 $t=0$ ，板东侧温度突降至$0\mathrm{^o C}$，西侧面保持绝热，板厚$L=2\mathrm{cm}$，导热系数$k=10 W\cdot\mathrm{m^{-1}\cdot K^{-1}}$，体积热容 $\rho c=1.0\times 10^7\mathrm{J\cdot m^{-3}\cdot K^{-1}}$

    采用显式格式，选用合理时间步长，计算 $t=40~s、t=80~s、t=120~s$ 时板的温度分布，比较分析数值计算解与解析解。


    



