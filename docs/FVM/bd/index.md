以下是 **三种常见边界条件** 及其对应的英文名称和解释：

---

### 1. **Dirichlet Boundary Condition（狄利克雷边界条件）**
- **定义**：在边界上**指定变量的值**。
- **表达式**：例如 \( C(0) = C_0 \)
- **英文描述**：Specifies the value of the dependent variable at the boundary.

---

### 2. **Neumann Boundary Condition（诺伊曼边界条件）**
- **定义**：在边界上**指定变量的一阶导数的值**，通常是通量。
- **表达式**：例如 \( \frac{dC}{dx}\Big|_{x=0} = q \)
- **英文描述**：Specifies the value of the derivative (often flux) of the dependent variable at the boundary.

---

### 3. **Robin Boundary Condition（罗宾边界条件）**
- **定义**：在边界上**指定变量和其导数的线性组合**。也称为“混合边界条件”。
- **表达式**：例如 \( aC + b\frac{dC}{dx} = g \)
- **英文描述**：Specifies a linear combination of the dependent variable and its derivative at the boundary.

 