Title: On Suboptimality of the Berger-Tung Bounds
Date: 2018-6-27 2:50:00
Authors: Christian Chapman
Slug: bt-inner-suboptimal
---

The Berger-Tung inner and outer bounds give a approximation to the rate-distortion region in lossy distributed source coding. The regions are not tight in general. Their tightness is discussed throughout Chapter 12 of *Network Information Theory* by El Gamal and Kim (in particular Section 12.5), but even so I always have to think a while to convince myself they are sub-optimal. Here is my understanding of the situation.

---

First, a statement of the distributed lossy source coding problem for two receivers:

> A source $(X_{1,t},X_{2,t})$ is iid in time $t$. Receiver $i$ ($i=1,2$) observes $X_i$ $T$ times: $(X_{i,t})_{t\in[T]}$ and processes it through $f_i$ into a message $M_i=f_i((X_{i,t})_{t\in[T]})$ with rate $R_i$ (i.e. $H(M_i)\leq TR_i$). Receiver $i$ forwards $M_i$ to a base.
> The base processes the receiver's messages $(M_i)_{i=1,2}$ through decoders $(g_i)_{i=1,2}$ into estimates $(g_i((M_j)_{j=1,2}))_i=((\hat{X}_{i,t})_{t\in [T]})_{i=1,2}$.
>
> For distortion measures $d_1(x_1,\hat{x}_1),\ d_2(x_2,\hat{x}_2)\geq 0$, what rate-distortion pairs $(R_1,D_1),\ (R_2,D_2)$ are achievable?
>
> For distortion measures $d_1,d_2$, then $(\ (R_i,D_i)\ )_{i=1,2}$ is "achievable" if for any $\varepsilon>0$ and $T$ large enough then encoders $(f_i)_{i=1,2}$ and decoders $(g_i)_{i=1,2}$ exist so that for $i=1,2$, receiver $i$ forming $M_i=f_i ((X_{i,t} ) _{t\in [T]})$ and base forming $(\hat{X} _{i,t}) _{t\in [T]} = g_i((M_j)_{j=1,2})$ then 
>
> - $H(M_i)\leq TR_i$,
> - $P\left( \frac{1}{T} \sum _{\ell=1}^T d_i(X_{i,\ell},\hat{X} _{i,\ell}) \geq D _i \right) < \varepsilon.$

Now the bounds:

> *Berger-Tung inner bound*: $(R_i,D_i)_{i=1,2}$ is achievable if there are random variables $(U_1,U_2,Q)$ where:
> 
> - $R_1>I(X_1;U_1|U_2,Q)$,
> - $R_2>I(X_2;U_2|U_1,Q)$,
> - $R_1+R_2>I(X_1,X_2;U_1,U_2|Q)$,
> - There are decoder functions $g^\ast_i(u_1,u_2,q)$ so that $\langle d_i(X_i,g^\ast_i(U_1,U_2,Q))\rangle<D_i$  for $i=1,2$,
> - The PMF of $(X_1,X_2,U_1,U_2,Q)$ can be factored: $P_{X_1,X_2}\cdot P_Q\cdot P_{U_1|X_1,Q}\cdot P(U_2|X_2,Q)$
> (It suffices to check $U_i$ with $\operatorname{Image}(U_i)\leq \operatorname{Image}(X_i)+4$)
>
> -----
>
> *Berger-Tung outer bound*: For $(R_i,D_i)_{i=1,2}$ to be achievable, then there must be some random variables $(U_1,U_2)$ which satisfy:
>
> - $R_1>I(X_1,X_2;U_1|U_2)$,
> - $R_2>I(X_1,X_2;U_2|U_1)$,
> - $R_1+R_2>I(X_1,X_2;U_1,U_2)$,
> - There are decoder functions $g^\ast_i(u_1,u_2)$ so that $\langle d_i(X_i,g^\ast_i(U_1,U_2))\rangle<D_i$  for $i=1,2$,
> - $(X_1,X_2,U_1,U_2)$ satisfies the Markov conditions: $U_1 \leftrightarrow X_1 \leftrightarrow X_2$ and $X_1\leftrightarrow X_2 \leftrightarrow U_2$.

----

Because of the correlation between $X_1$ and $X_2$, Receiver 1's observation of $X_1$ contains some information about the other source's realization, $X_2$. This means Receiver 1 may have some information about the result of Receiver 2's processing on $X_2$. In particular Receiver 1 may be able to derive some knowledge of $U_2$, Receiver 2's message content. It can use this knowledge of $U_2$'s realization to improve its own message content $U_1$.

The inner bound's PMF factoring restriction is too strong. It enforces that Receiver 1's message be independent of all the other receivers' messages after conditioning on Receiver 1's observation. This disallows Receiver 1 from using its knowledge of Receiver 2's message realization to improve its own. An example where this helps is given in Section 12.5.

The outer bound's Markov constraint is too lax. It allows for arbitrary dependence between messages after conditioning on their respective receiver's observations, even when such dependence is not possible. For example, if $X_1,X_2$ are jointly Gaussian then the Markov constraint allows $U_1=X_1+N_1+N_c,\ U_2=X_2+N_c$ where $N_1,N_c$ are independent Gaussian distortions. Indeed, we can verify that $U_2\to X_2 \to X_1$ and $U_1\to X_1 \to X_2$ and that noise powers can be made for the outer bound's entropy conditions to hold, but clearly the scheme can't be realized besides some trivial edge cases. 

The discrepancy between the inner and outer bound is that depending on the channel, Receiver 1 varies in its ability to observe what specific parts of its source are lost or retained during Receiver 2's lossy reduction of $X_2$ into $U_2$. (And vice versa for Receiver 2).
