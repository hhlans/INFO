
# Gradient Descend

## Eigenvalue Theory 
Let $A(A\in \mathbb{R}^{n\times n})$ be a square matrix, a scalar $\lambda (\lambda\in\mathbb{R})$ is called an *eigenvalue* of $A$ if there exists a non-zero vector $\mathbf{v}(\mathbf{v}\in\mathbb{R}^{n})$ such that 

$$A\mathbf{v}=\lambda\mathbf{v}$$

where the non-zero vector is called an *eigenvector* corresponding the eigenvalue $\lambda$.

A symmetric matrix such that

$$A=A^\mathrm{T}$$

That is, $a_{ij}=a_{ji}$ for all $i,j$.

If $A(A\in \mathbb{R}^{n\times n})$ is symmetric, all eigenvalues of $A$ are real.

If $A(A\in \mathbb{R}^{n\times n})$ is symmetric, eigenvectors corresponding to distinct Eigenvalues of $A$ are orthogonal.

If $\mathbf{x}^\mathrm{T}A\mathbf{x}>0(A\in \mathbb{R}^{n\times n})$ for all non-zero vectors $\mathbf{x}(\mathbf{x}\in\mathbb{R}^{n})$, the matrix $A$ is *positive definite*.

## Introduce to Gradient Descend

Error function $E(\mathbf{w})$, $\mathbf{w}$ denotes the weight space, a single vector. Optimizing $\mathbf{w}$ by using a chosen error function.

Make a step in weight space from $\mathbf{w}$ to $\mathbf{w+\delta w}$, the change in error function is given by

$$\delta E(\mathbf{w})=\delta \mathbf{w}^\mathrm{T}\nabla E(\mathbf{w})\tag{1-1}$$

where the vector $\nabla E(\mathbf{w})$ points in the direction of the greatest rate of increase of error function. Provided that the error function $E(\mathbf{w})$ is smooth, continuous function of $\mathbf{w}$, its local smallest value will occur at a point in a weight space such that the gradient of the error function vanishes, so that 

$$\nabla E(\mathbf{w})=0 \tag{1-2}$$

as otherwise we could make a small step in the direction of $-\nabla E(\mathbf{w})$ and thereby further reduce the error. The point where gradient vanishes is called stationary point and could be futher classified into minima, maxima and saddle points.

We aim to find a vector $\mathbf{w}$ such that the $E(\mathbf{w})$ takes its smallest value. However, the error function typically has highly nonlinear dependence on the weight and bias parameters, and so there will be many points at which the gradient vanishes. 

Futhermore, there may be multiple non-equivalent stationary point and particular multiple minima. A minima that corresponds to the smallest value of the error function across the whole of weight space is said to *gobal minimum*. Any other minima that corresponds to the smaller value of the error function is said to *local minima*.

The error surfaces for neural networks can be very complex, and it is thought that gradint-based methods might be easily trapped in poor local minima. In practise, it seems not to be the case, and large neural networks can reach solution with similar performence under a variety of initial conditions.

## Local Quadratic Approximation

Insight into the optimization problem and into various techniques for solving it can be obtained by considering a local quadratic approximation to the error function. The Taylor expansion of $E(\mathbf{w})$ around some points $\mathbf{\hat{w}}$ in weight space is given by 

$$E(\mathbf{w})\simeq E(\mathbf{\hat{w}})+(\mathbf{w}-\mathbf{\hat{w}})^\mathrm{T}\mathrm{b}+\frac{1}{2}(\mathbf{w}-\mathbf{\hat{w}})^\mathrm{T}\mathbf{H}(\mathbf{w}-\mathbf{\hat{w}})\tag{2-1}$$

where cubic and higher terms is omitted. Here $\mathrm{b}$ is defined to be the gradient of $E(\mathbf{w})$ evaluated at $\mathbf{\hat{w}}$ by 

$$\mathrm{b}\equiv\nabla E\mid_{\mathbf{w=\hat{w}}}\tag{2-2}$$

The *Hessian* is defined to be the corresponding matrix of second derivatives

$$\mathbf{H(\hat{w})}=\nabla\nabla E(\mathbf{w})\mid_{\mathbf{w=\hat{w}}}\tag{2-3}$$

If there is a total of $W$ weight and bias in the networks, and then $\mathbf{w}$ and $\mathrm{b}$ have length $W$ and $\mathbf{H}$ has dimentionity $W\times W$. From $(2-1)$, the local approximation to the gradient is given by 

$$\nabla E\mathbf{(\hat{w})}\simeq (\mathbf{w}-\mathbf{\hat{w}})+\mathbf{H}(\mathbf{w}-\mathbf{\hat{w}})\tag{2-4}$$

For the point $\mathbf{w}$ is sufficiently colsed to $\mathbf{\hat{w}}$, these experssions will give reasonable approximation for the error function and its gradient.

Considering a particular case that of a quadratic approximation arroun a point $\mathbf{w^*}$ that is a minimum of the error function. In this case there is no linear term, because $\nabla E(\mathbf{w})=0$ at $\mathbf{w^*}$, and $(2-1)$ can simplified by

$$E(\mathbf{w})\simeq E(\mathbf{w^*})+\frac{1}{2}(\mathbf{w}-\mathbf{w^*})^\mathrm{T}\mathbf{H}(\mathbf{w}-\mathbf{w^*})\tag{2-5}$$

To interpret this geometrically, consider the eigenvalue function for the Hessian matrix

$$\mathbf{Hu}_i=\lambda_i\mathbf{u}_i$$

If $\mathbf{w}^*$ is a minimum of error, $\mathbf{H}$ is positive definite matrix and there exists a set, $\{\mathbf{u}_i\}$ that form a complete orthonormal set and $\lambda_i>0$ for all $i$.

