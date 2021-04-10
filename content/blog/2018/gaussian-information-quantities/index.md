Title: Some Useful Multivariate Gaussian Information Quantities
Date: 2018-4-2 2:50:00
Authors: Christian Chapman
Slug: gaussian-information-quantities
---

Many information quantities for multivariate normal distributions have nice closed forms. Their essential parts usually reduce to logs of minor determinant quotients so they combine nicely. Here's a list of them. All of them are somewhere in [Adaptive Wireless Communications by Bliss and Govindasamy](https://www.amazon.com/Adaptive-Wireless-Communications-Channels-Networks/dp/1107033209).


Notation
--

 * $[n]=\{1,\dots,n\}$
 * $(x_n)_n$ ($(x_n)$ for short) is a vector indexed by $n$
 * $(x_n)_{n\in S}$ (or $(x_n)_S$) is the sub-vector of $(x_n)_n$ consisting only of elements from $S$
 * If $A$ is an $n\times n$ matrix and $S\subset [n]$ is nonempty, then $A_S$ is the matrix formed by deleting all rows and columns of $A$ in $[n]\backslash S$. Note in particular if $A$ is positive-definite then $A_S$ is too.
 * $|S|$ is the number of elements in $S$.
 
All covariance matrices are assumed to be full-rank. By convention the determinant of an empty matrix is 1.
 
Real Identities
--

 * $X \sim \mathcal{N}(0,\sigma^2),$ then: 

	$$h(X) = \frac{1}{2}\ln\left(2\pi e \sigma^2\right)$$

 * $(X_n) \sim \mathcal{N}(0,A),\ S\subset [n]$ then: 

	$$h\left( (X_n)_S \right) = \frac{1}{2}\ln\left((2\pi e)^{|S|} \operatorname{det}(A_S)\right)$$

 * $(X_n) \sim \mathcal{N}(0,A),\ S,T\subset [n]$ then:

	$$h\left( (X_n)_S | (X_n)_T \right) = \frac{1}{2}\ln \left((2\pi e)^{|S\cup T|-|T|} \frac{\operatorname{det}(A_{S\cup T})}{\operatorname{det}(A_T)}\right)$$

 * $(X_n) \sim \mathcal{N}(0,A),\ S,T\subset [n]$ and $S\cap T = \varnothing$ then:

	$$I\left( (X_n)_S ; (X_n)_T \right) = \frac{1}{2}\ln\left(\frac{\operatorname{det}(A_S)\operatorname{det}(A_T)}{\operatorname{det}(A_{S\cup T})}\right)$$

 * $(X_n) \sim \mathcal{N}(0,A),\ S,T,U\subset [n]$ and $S\cap T=\varnothing$ then:

	$$I\left( (X_n)_S ; (X_n)_T\middle|(X_n)_U\right) = \frac{1}{2}\ln\left(\frac{\operatorname{det}(A_{S\cup U})\operatorname{det}(A_{T\cup U})}{\operatorname{det}(A_{S\cup T\cup U})\operatorname{det}(A_U)}\right)$$
 
[Circularly-symmetric complex normal](https://en.wikipedia.org/wiki/Complex_normal_distribution#Circularly-symmetric_normal_distribution) identities are identical except without the $\frac{1}{2}$ factor. 
