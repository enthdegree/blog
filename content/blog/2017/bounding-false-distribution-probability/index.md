Title: Point KL-Divergence is not Very Negative Very Often
Date: 2017-5-14 2:50:00
Authors: Christian Chapman
Slug: bounding-false-distribution-probability
---
If $X\sim P$ then for any distribution $Q$ it is unlikely that $Q$ ascribes much greater density to $X$'s outcome than $P$ does. In fact if $P,Q$ have PDFs $f_P, f_Q$, then: 

\begin{align}
    \mathbb{P}(f_P(X)\leq c f_Q(X)) &= \int \mathbf{1}_{\{x:f_P(x)\leq  cf_Q(x) \}} f_P(x)dx \\
    &\leq \int c f_Q(x) dx \\
    &= c.
\end{align} 

This carries over to relative entropy:

Noting $D_{KL}(P\|Q)=\mathbb{E}[Z]$ for $Z=\ln \frac{f_P(X)}{f_Q(X)}$, then for any $z,$

\begin{align}
    \mathbb{P}(Z\leq z) &= \mathbb{P}\left(\ln \frac{f_P(X)}{f_Q(X)} \leq z \right) \\
    &= \mathbb{P}(f_P(X)\leq e^z f_Q(X)) \\
    &\leq e^z.
\end{align}

This is actually just an interesting instance of the [Chernoff bound](https://en.wikipedia.org/wiki/Chernoff_bound). The same thing can be done when $P,Q$ aren't over $\mathbb{R}$ or don't have CDFs, or even with other types of divergences.
