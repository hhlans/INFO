# 一维稳态扩散有限体积法

One-dimensional steady-state diffusion finite volume method（1D SS Diffusion FVM）

## 1. INTRODUCE

此扩散非彼扩散。

在一维稳态系统中，取 $\mathrm{d}x$ 薄层控制体对任意场量衡算有
进入控制体量-离开控制体量+源项=0

即对任意场量 $\varphi$ 有

$$\Gamma(-\frac{\mathrm{d} \varphi}{\mathrm{d}x}\Big\rvert_{x})-\Gamma\Big(-\frac{\mathrm{d} \varphi}{\mathrm{d}x}\Big\rvert_{x+\Delta x}\Big)+S\Delta x=0 \tag{2}$$

其中 $\Gamma$ 为扩散系数，化简得到一维稳态扩散问题的控制微分方程

$$\frac{\mathrm{d}}{\mathrm{d}x}(\Gamma\frac{\mathrm{d}\varphi}{\mathrm{d}x})+S=0\tag{3}$$

## 2. 生成离散网格

## 3. 方程的离散

高斯散度定理：向量场穿过曲面的通量，等于散度在曲面围起来的体积上的积分。

$$\int_{V} \nabla\cdot\mathbf{F} \, dV = \oint_{A} \mathbf{n}\cdot\mathbf{F}  ~dA\tag{4}$$

对式（3）积分后使用高斯散度定理有

$$\begin{align}
&\int_{\Delta V}\frac{\mathrm{d}}{\mathrm{d}x}(\Gamma\frac{\mathrm{d}\varphi}{\mathrm{d}x})~\mathrm{d}V+\int_{\Delta V}S~\mathrm{d}V\\
=&\oint_A\mathbf{n}\cdot\Gamma\frac{\mathrm{d}\varphi}{\mathrm{d}x}~\mathrm{d}A+\int_{\Delta V}S~\mathrm{d}V\\
=&(\Gamma\frac{\mathrm{d}\varphi}{\mathrm{d}x})_e-(\Gamma\frac{\mathrm{d}\varphi}{\mathrm{d}x})_w+\overline{S}\Delta V\\
=&0
\end{align}\tag{5}$$

网格边界场变量 $\varphi$ 梯度和扩散系数 $\Gamma$ 的值，可用线性差值求得

$$\Gamma_w = \frac{\Gamma_W+\Gamma_P}{2},\Gamma_e = \frac{\Gamma_P+\Gamma_E}{2}\tag{6}$$

$$\frac{\mathrm{d}\varphi}{\mathrm{d}x}\Big\rvert_w=\frac{\varphi_P-\varphi_W}{\delta x_{WP}},\frac{\mathrm{d}\varphi}{\mathrm{d}x}\Big\rvert_e=\frac{\varphi_E-\varphi_P}{\delta x_{PE}}\tag{7}$$

所以通过界面扩散量

$$\begin{align}
(\Gamma A\frac{\mathrm{d}\varphi}{\mathrm{d}x})_w=\Gamma_w A_w(\frac{\varphi_P-\varphi_W}{\delta x_{WP}})\\
(\Gamma A\frac{\mathrm{d}\varphi}{\mathrm{d}x})_e=\Gamma_e A_e(\frac{\varphi_E-\varphi_P}{\delta x_{PE}})
\end{align}\tag{8}$$

有限体积法一般将源项作线性化处理，关于源项线性化处理的细节不进一步展开，可用参考[文章](https://zhuanlan.zhihu.com/p/354095923)


$$\overline{S}\Delta V=S_u+S_P\varphi_P\tag{9}$$

式（6）（7）（8）（9）代入（5）离散方程有

$$\Gamma_e A_e(\frac{\varphi_E-\varphi_P}{\delta x_{PE}})-\Gamma_w A_w(\frac{\varphi_P-\varphi_W}{\delta x_{WP}})+\overline{S}\Delta V+(S_u+S_P\varphi_P)=0\tag{10}$$

式（10）按节点场变量整理有

$$\Big(\frac{\Gamma_e }{\delta x_{PE}}A_e+\frac{\Gamma_w }{\delta x_{WP}}A_w-S_P\Big)\varphi_P=
\frac{\Gamma_w }{\delta x_{WP}}A_w\varphi_W+\frac{\Gamma_e }{\delta x_{PE}}A_e\varphi_E+S_u\tag{11}$$

变量系数归一化处理

$$a_P\varphi_P=a_W\varphi_W+a_E\varphi_E+S_u\tag{12}$$

式中

$$a_W=\frac{\Gamma_w }{\delta x_{WP}}A_w,a_E=\frac{\Gamma_e }{\delta x_{PE}}A_e,a_P=a_W+a_E-S_P\tag{13}$$

方程（12）即为一维稳态扩散方程的离散方程，对所有节点列出列出离散方程，即可得到一组代数方程，对代数方程的具体解法暂不具体展开。



---

## 示例 1.无热源-恒导热系数一维稳态导热问题求解

!!! question
    绝热棒长 $L=0.5\mathrm{m}$ ，截面积 $A=10\times10^{-3}\mathrm{m^2}$，左端温度 $T_A$ 保持 $100^\circ\mathrm{C}$，右端温度 $T_B$ 保持 $500^\circ\mathrm{C}$ ，材料导热系数 $k=1000W/(m\cdot K)$，求材料温度分布。

取控制体作热量衡算

$$\begin{align}
&kA\frac{\mathrm{d}T}{\mathrm{d}x}\Big\rvert_{x}-kA\frac{\mathrm{d}T}{\mathrm{d}x}\Big\rvert_{x+\Delta x}+\int_{\Delta V} q~\mathrm{d}V\\
=&kA\frac{\mathrm{d}T}{\mathrm{d}x}\Big\rvert_{x}-kA\frac{\mathrm{d}T}{\mathrm{d}x}\Big\rvert_{x+\Delta x}+A\int_{\Delta x} q~\mathrm{d}x
\end{align}\tag{14}$$

即得到一维稳态导热问题的控制方程，在此案例中无热源$q=0$。

$$\frac{\mathrm{d}}{\mathrm{d}x}(k\frac{\mathrm{d}T}{\mathrm{d}x})+q=0\tag{15}$$


**第一步生成离散网格**

将一维求解域划分成10个控制体

**第二步构造离散方程**

2～9号控制体离散方程具有一般性，无热源 $q=0$ ，利用式（12）可列出节点温度离散方程

$$a_PT_P=a_WT_W+a_WT_W\tag{16}$$

式中

$$a_W=\frac{k}{\delta x}A,a_E=\frac{k}{\delta x}A,a_P=a_W+a_E\tag{17}$$

特殊地，对节点 1 ，不存在节点 $W$ ，但存在边界条件 $T_A=100~^oC$ ，式（15）在节点 1 控制体积分

$$\int_{\Delta V}\Big[\frac{\mathrm{d}}{\mathrm{d}x}(k\frac{\mathrm{d}T}{\mathrm{d}x})\Big]\mathrm{d}V=(kA\frac{\mathrm{d}T}{\mathrm{d}x})_e-(kA\frac{\mathrm{d}T}{\mathrm{d}x})_w\tag{18}$$

其中

$$(kA\frac{\mathrm{d}T}{\mathrm{d}x})_w=kA\frac{T_P-T_A}{\delta x/2},
(kA\frac{\mathrm{d}T}{\mathrm{d}x})_e=kA\frac{T_E-T_P}{\delta x}\tag{19}$$

将式（18）代入（18）并按节点整理有

$$(\frac{k}{\delta x}A+\frac{2k}{\delta x}A)T_P=0\times T_W +(\frac{k}{\delta x}A)T_E+(\frac{2k}{\delta x}A)T_A\tag{20}$$

从而边界节点 1 的离散方程可以写为

$$a_PT_P=a_WT_W+a_WT_W\tag{21}$$

其中

$$a_W=0,a_E=\frac{k}{\delta x}A,a_P=a_W+a_E-S_P,S_P=-\frac{2k}{\delta x}A,S_u=\frac{2k}{\delta x}A\cdot T_A\tag{22}$$

同理节点10离散方程

$$a_PT_P=a_WT_W+a_WT_W\tag{23}$$

其中

$$a_W=\frac{k}{\delta x}A,a_E=0,a_P=a_W+a_E-S_P,S_P=-\frac{2k}{\delta x}A,S_u=\frac{2k}{\delta x}A\cdot T_B\tag{24}$$

**第三步解代数方程**

得到代数方程

$$
y=
\begin{cases}
300T_1=200T_A+100T_2\\
200T_2=100T_1+100T_3\\
200T_3=100T_2+100T_4\\
200T_4=100T_3+100T_5\\
200T_5=100T_4+100T_6\\
200T_6=100T_5+100T_7\\
200T_7=100T_6+100T_8\\
200T_8=100T_7+100T_9\\
200T_9=100T_8+100T_{10}\\
300T_{10}=100T_9+200T_B\\
\end{cases}
\tag{25}
$$

写成矩阵形式有

$$A=
\begin{bmatrix}
300 & -100 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
-100 & 200 & -100 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & -100 & 200 & -100 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & -100 & 200 & -100 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & -100 & 200 & -100 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & -100 & 200 & -100 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & -100 & 200 & -100 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & -100 & 200 & -100 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & -100 & 200 & -100 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & -100 & 300
\end{bmatrix}
$$

$$\mathbf{T}=
\begin{bmatrix}
T_1 & T_2  &T_3 & T_4 & T_5 & T_6 & T_7 & T_8 & T_9 & T_{10}
\end{bmatrix}^T
$$

$$\mathbf{b}=
\begin{bmatrix}
200T_A & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 200T_B
\end{bmatrix}^T
$$

线性方程方程组 $A\cdot \mathbf{T}=\mathbf{b}$ 用 $MATLAB$ `inv(A)*b`解得

$$\mathbf{T}=
\begin{bmatrix}
120 & 160 & 200 & 240 & 280 & 320 & 360 & 400 & 440 & 480
\end{bmatrix}^T\tag{26}$$

## 示例 2.恒导热源-恒导热系数一维稳态导热问题求解

!!! question
    厚度 $L=2\mathrm{cm}$的无限大平板，导热系数 $k=0.5~W/(m\cdot K)$ ，板内存在均匀热源 $q=1000~\mathrm{kW/m^2}$ ，左端温度 $T_A$ 保持 $100~^oC$ ，右端温度 $T_B$ 保持 $200~^oC$ ，求板内温度分布。

可看作一维稳态导热问题，热量衡算如（14），其数学模型为

$$\frac{\mathrm{d}}{\mathrm{d}x}(k\frac{\mathrm{d}T}{\mathrm{d}x})+q=0\tag{27}$$

边界条件

$$T\Big\rvert_{x=0}=T_A,T\Big\rvert_{x=L}=T_B$$


