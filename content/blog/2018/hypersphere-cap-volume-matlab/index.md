Title: Hypersphere Cap Volumes in Matlab 
Date: 2018-7-13 1:50:00
Authors: Christian Chapman
Slug: hypersphere-cap-volume-matlab
---

The volume of a height-$h$ cap of a ball of radius $r$ in dimension $n$ can be [derived](https://en.wikipedia.org/wiki/Spherical_cap#Hyperspherical_cap):

\begin{equation}
   \operatorname{vol}(\operatorname{cap}) = \frac{1}{2} \cdot 
	\frac{\pi^{n/2}}{\Gamma\left(1+n/2\right)} \cdot
	r^n \cdot 
    I_{(2rh-h^2)/r^2}\left((n+1)/2, 1/2\right)
\end{equation}

where $I_x(a,b)$ is the regularized incomplete beta function. In high dimension each of these terms can be extremely small or large, so rounding errors accumulate quickly. In moderate dimension this can be overcome by working with the quantity's log. Here is a simple matlab function that does this:

**[log_cap_vol.m](https://github.com/enthdegree/log_cap_vol.m)**.

As of 2018-7-13, this function involves taking the log of matlab's regularized incomplete beta function `betainc`. If there is numerical imprecision in `log(betainc(.))`, it is necessary to replace this with a formula involving `betaln`, some constants and an approximation of the log of Gauss' hypergeometric function. The comment at the top of the .m file describes this formula should the need arise.


