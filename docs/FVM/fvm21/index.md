# 一维稳态对流扩散问题的有限体积法

## 1. INTRODUCE

**以流体流动中主体流动和分子扩散控制微分方程推导为例**，对一维对流传热仍然适用，只需根据傅立叶导热定律建立扩散项即可。

Fick 扩散定律有

$$J_x=-D_x\frac{\mathrm{d}c}{\mathrm{d}x}\tag{1}$$

其中 $c$ 为摩尔浓度（ $\mathrm{mol}/\mathrm{m^3}$） ，$D$ 为扩散系数 （ $\mathrm{mol\cdot m^{-2}\cdot s^{-1}}$ ），取薄层控制体作质量衡算

$$\begin{align}
&\Bigg[(J\cdot A)_{x}-(J\cdot A)_{x+\Delta x}\Bigg]+\Bigg[(\frac{q_m}{\rho}c)_{x}-(\frac{q_m}{\rho}c)_{_{x+\Delta x}}\Bigg]=0\\
\Longrightarrow&\Bigg[(-D\frac{\mathrm{d}c}{\mathrm{d}x}\cdot A)_{x}-(-D\frac{\mathrm{d}c}{\mathrm{d}x}\cdot A)_{x+\Delta x}\Bigg]+\Bigg[(uA\cdot c)_{x}-(uA\cdot c)_{x+\Delta x}\Bigg]=0\\
\end{align}\tag{2}$$

一维稳态下面积不变

$$\begin{align}
&\Bigg[(-D\frac{\mathrm{d}c}{\mathrm{d}x})_{x}-(-D\frac{\mathrm{d}c}{\mathrm{d}x})_{x+\Delta x}\Bigg]+
\Bigg[(u\cdot c)_{x}-(u\cdot c)_{x+\Delta x}\Bigg]=0\\
\Longrightarrow&
\frac{\mathrm{d}}{\mathrm{d}x}(D\frac{\mathrm{dc}}{\mathrm{d}x})=\frac{\mathrm{d}(uc)}{\mathrm{d}x}
\end{align}\tag{3}$$

式（3）即为包含主体流动和分子扩散问题的控制微分方程，其必须满足连续性假定，即

$$\frac{\mathrm{d}(\rho u)}{\mathrm{d}x}=0$$

## 2. 方程离散





