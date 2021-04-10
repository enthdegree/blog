Title: Extracting Relevant Information over Many Trials
Date: 2020-12-25 13:00:00
Modified: 2021-1-4 13:00:00
Authors: Christian Chapman
Slug: extracting-relevant-information
---

The [information bottleneck](https://arxiv.org/pdf/physics/0004057.pdf) scenario goes like this:

> We are interested in a quantity \(Y\) but only observe \(X\) which we must process down to a rate \(R \in (0, H(X)).\) To this end, what random variables \((U,Q)\) minimize \(H(Y|U,Q)\) while satisfying \(U\perp Y | X\), \(Q\perp (X,Y)\) and \(H(U|Q)<R\)?

This minimization is characterized by a functional equation discussed in the above link. 
Does the situation change when you are allowed to process over many random trials instead of just one? 
An example question might sound like this:

> Is it easier to specify the result of 1000 coin tosses with 500 bits than it is to describe 1 coin toss with half a bit, when you only learn about each coin toss outcome through independent identically distributed noise? 

I believe the answer is no, and that the many trials/coin tosses scenario's solution has the same essential form as the single-letter information bottleneck. 
What follows is a sketched proof. It is certainly possible there is a big gap somewhere in it, many typos, and/or that there is a much simpler argument I haven't been able to think of. On the other hand, neither have I found any heuristics that suggest this could be false.

The new question can be formulated like this:

> Write \(n\) iid trials of \((X,Y)\) as \((X^n, Y^n)\) and fix \(R\in (0,H(X)).\) 
> What is \(\lim _ n \min _ {f: \mathrm{Range}\ f = [\exp nR]} \frac{1}{n} H(Y^n|f(X^n))\)?

### Claim 

>\begin{equation}
\lim _ n \min _ {f: \mathrm{Range}\ f = [\exp nR]} \frac{1}{n} H(Y^n|f(X^n)) = \min _ {\substack{U,Q: \ Q\perp(X,Y) \\ U\perp Y | X,\ H(U) < R}} H(Y|U,Q) \tag{\(\ast\)}.
\end{equation}

### Argument
We set out to construct a single-letter encoder that performs practically as well as any multi-letter encoder. 
We find that among the best-performing multi-letter encoders, there are those that always specify the sequence of observations \(X _ 1,\dots, X _ n\) practically to within a 'rectangular' set \(s _ 1\times \dots \times s _ n, \ s _ i \subset \mathcal{X}\) where the amount of likely sequences in this rectangle is \(\sim\exp(n(H(X)-\text{encoder entropy rate}))\). 
Finally we find that a multi-letter encoder with this characteristic is matched in performance by a single-letter encoder with practically the same entropy rate using the lemma [here](https://ebn0.net/multivariate-function-reduction-to-single-letter-rvs.html). 

----

Without loss of generality it is sufficient to restrict our attention to multi-letter encoders \(f\) with some regularity. 
Fix \(n, \varepsilon > 0\) and take \(f\) where:

 - There is a collection \(\mathcal{T}\subset \mathcal{Y}^n\times \mathcal{X}^n \times [\exp nR]\) for \((Y^n, X^n, f(X^n))\) where \(P(\mathcal{T})>1-\varepsilon\) and  all \(\omega \in \mathcal{T}\) are approximately equiprobable with \( P((Y^n, X^n, f(X^n)) = \omega) \in \exp(-n(H(X,Y)\pm \varepsilon)).\)
 - Writing the projection of \(\mathcal{T}\) onto \([\exp nR]\) as \(\mathcal{T} _ f\subset [\exp nR]\), then there is some \(\rho _ f > 0\) where \(|\mathcal{T} _ f| \in \exp n(\rho _ f\pm \varepsilon)\) and  where all \(m\in \mathcal{T} _ f\) are approximately equiprobable with \(P(m) \in \exp(-n(\rho _ f \pm \varepsilon)).\)
 - There is some \(\rho _ {X|f}>0\) so that for each \(m\in \mathcal{T} _ f\), taking \(\mathcal{T} _ X(m):=\{x^n: (y^n,x^n,m)\in \mathcal{T}\}\subset \mathcal{X}^n\) then this set consists of \(\varepsilon\)-typical sequences for \(X^n\), \(P \left( X^n \in \mathcal{T} _ X(m) | f(X^n) = m \right) > 1-\varepsilon\),  and \(|\mathcal{T} _ X(m)| \in \exp(n(\rho _ {X|f} \pm \varepsilon))\)

 We can focus exclusively on \(f\) with these properties since for *any* \(f:\mathcal{X}^n\to [\exp nR]\), take \(N \gg n\) and consider the function \(f^N:\mathcal{X}^N\to [\exp NR]\) on \(X^N\) gotten from applying \(f\) on each successive sequence of \(n\) variables, (discarding whatever variables are left over): 

\begin{equation}
	f^N(X^N) := (f(X _ {1+(k-1)\cdot n},\dots X _ {n+(k-1)\cdot n})) _ {k=1}^{\lfloor N/n \rfloor}
\end{equation} 

(interpreting the output as an \(\lfloor N/n\rfloor\)-digit integer written in base-$\exp nR$). 
This will make the $(\ast)$ objective \(\frac{1}{N} H(Y^N|f^N(X^N)) \leq \frac{1}{n}H(Y^n|f(X^n))+O(\frac{n}{N}).\) 
For any \(\varepsilon > 0\) and \(k>0\) large enough, then a jointly-letter-typical set \(\mathcal{T}^k _ \varepsilon(Y^n, X^n,f(X^n))\) and its marginals will have the prescribed properties for \(\mathcal{T}.\) 
(Letter-typicality is required over weak typicality here but is used later.)
Notice that in this typical set we are considering \(k\) repetitions of the length-\(n\) sequences \((Y^n, X^n, f(X^n))\) themselves. 
Detail for facts about letter typical sets are presented in the first several chapters of Cover.

 Now consider the following computation: 

\begin{align}
	H(Y^n|f(X^n)) &= \sum _ {m\in \mathcal{T} _ f \cup (\text{Range}\ f)\backslash \mathcal{T} _ f} P(f(X^n)=m)H(Y^n|f(X^n)=m) \\
	&\in [0, \varepsilon \cdot n\log |\mathcal{Y}|] + \sum _ {m\in \mathcal{T} _ f } P(f(X^n)=m)H(Y^n|f(X^n)=m). \tag{\(\S\)}
\end{align}

For $m\in \mathcal{T} _ f$ consider further 

\begin{align}
	H(Y^n|f(X^n)=m) &\in [0,1] + H(Y^n|X^n \in f^{-1}(m),\ \mathbb{1} _ {X^n \in \mathcal{T} _ {X}(m)}) \\
	&\subset [0,1+\varepsilon \cdot n\log |\mathcal{X}|] + H(Y^n|X^n \in \mathcal{T} _ {X}(m))
\end{align}

Returning to $(\S)$ with this,

\begin{align}
	(\S) &\subset [0, 1+\varepsilon \cdot n\log |\mathcal{X}\times \mathcal{Y}|] + (1\pm \varepsilon)\cdot \{H(Y^n|X^n\in \mathcal{T} _ X(m))\} _ {m\in \mathcal{T} _ f}.
\end{align}

----

So far we have bound the objective for a multi-letter encoder $f$ to within a set of negligible-width intervals, the location of each interval determined by a preimage of $f.$ 

Now we will study *"What is the least $H(Y^n|X^n\in T)$ could be over any collection $T$ of $\varepsilon$-typical sequences for $X^n$, with  $|T| \in \exp (n(\rho _ f \pm \varepsilon))$ ?"* 
From this we will find a $(U,Q)$ for which the distribution of \(X\) conditioned on \((U,Q)\) is similar to \(T\). 

----

Fix any \(T\subset \mathcal{T} _ X\) with \(T=\{x _ 1,\dots, x _ k\}\). Notice (see below [1]) \(H(Y^n|X^n \in T)\) is within \(O(n\varepsilon)\) of its minimum over all such \(T\) is when all of the components of the following vector are at a maximum

\begin{equation} 
	(|y^n : |x^n \in \{x _ i\} _ {i \in [\ell]} : (x^n, y^n) \text{ j.t.} | \geq \ell |) _ {\ell \in [k]},
\end{equation}

where this is a consistent criterion since the max for component \(\ell+1\) is attained within a subset of where maxes are attained for components from \(1\) through \(\ell\).  
Further for any \(\{x _ i\} _ {i \in [\ell]}\subset T\), compute:

\begin{align}
	\{y^n: (x^n, y^n) \text{ j.t.} \forall x^n \in \{x _ i\} _ {i \in [\ell]}\} &= \\
	\cap _ {j=1}^\ell \{y^n: \frac{1}{n} \sum _ {t=1}^n -\log p(y _ t| x _ {j,t}) \in H(Y|X) \pm \varepsilon \} &= \\
	\cap _ {j=1}^\ell \{y^n: \frac{1}{n} \sum _ {t=1}^n -\log p(y _ t| x _ {1,t}) +\frac{\log p(y _ t| x _ {1,t})}{\log p(y _ t| x _ {j,t})} \in H(Y|X) \pm \varepsilon \}. 
\end{align} 

The size of this set is characterized by the components of the vector \(\left( D(P(Y^n=\cdot | X^n = x _ 1 ) \| P(Y^n = \cdot | X^n = x _ i ) \right) _ {i \in [\ell]} \) where the set tends to size at least \(\exp(n(H(Y|X)-\varepsilon)\) if all the components are below \(n\varepsilon\) and size below \(n\varepsilon\) otherwise (see below [1]). 

Take \(P _ {X^n|T}\) as the product of empirical distributions of \(T\)'s marginals: 

\begin{align} 
	P _ {X^n|T} &: \mathcal{X}^n \to [0,1], \\
	P _ {X^n|T}(x _ 1,\dots x _ n) &:= \prod _ {t=1}^T \frac{|x^\ast\in T : x^\ast _ t = x _ t |}{|T|}
\end{align}

Then 

- \(|T'\cap \mathcal{T} _ X|\geq |T|\exp(-n\varepsilon)\) with probability \(\geq 1-\varepsilon\).
- Forming \(T'\subset \mathcal{X}^n\) by drawing \(|T|\) words iid \(\sim P _ {X^n|T}\) makes \(|H(Y^n|X^n\in T')-H(Y^n|X^n\in T)|\leq O(n\varepsilon)\) with probability \(\geq 1-\varepsilon\) due to the characterization just presented.

Consider a distribution \(P^\ast _ k\) over \(\mathcal{X}^n\) chosen as \(P^\ast _ k = \arg \min _ {P \in \mathcal{P} _ k} H(Y^n | X^n \sim P )\), where \(\mathcal{P} _ k\) is the collection of distributions \(P\) over \(\mathcal{X}^n\) with the following properties 

- \(P\) factors into the form \(P(x _ 1,\dots, x _ n) = \prod _ {t=1}^n \frac{\mathbb{1} _ {s _ t}(x _ t)}{|s _ t|}, \ s _ t \subset \mathcal{X} \), 
- with probability at least \(1-\varepsilon\), then \(k\) iid draws \(\sim P\) yield at least \(k \exp(-n\varepsilon)\) unique words in \(\mathcal{T} _ X\).  

Then factoring \(P^\ast _ k = \prod _ {t=1}^n \frac{\mathbb{1} _ {s^\ast _ t}}{|s^\ast _ t|}, \ s^\ast _ t \subset \mathcal{X} \), one can check that forming \(T^\ast\subset \mathcal{X}^n\) by drawing \(k\) words from \(P^\ast _ k\) makes \(|H(Y^n|X^n \in T^\ast) - H(Y^n| X^n \sim P^\ast _ k)| \leq O(n\varepsilon)\) with probability \(\geq 1-\varepsilon\) and with high probability \(T^\ast\) is within \(O(k)\) additions of being the set \(\prod _ {t=1}^n s^\ast _ t \).

Such \(T^\ast\) must have \(H(Y^n| X^n \in T^\ast) \) within \(O(n\varepsilon)\) of \(\min _ {T: |T\cap\mathcal{T} _ X| \geq k} H(Y^n | X^n \in T)\) since optimizing \(T\) and constructing \(T'\) as above makes \(H(Y^n|X^n\in T')\) within \(O(n\varepsilon)\) of \(H(Y^n|X^n\in T)\), and \(T^\ast\) itself is within \(O(n\varepsilon)\) of \(H(Y^n|X^n\in T')\).

---

We have seen that for any \(k\) then there is a choice of \(T: |T\cap \mathcal{T} _ X|\geq k\) so that \(H(Y^n| X^n \in T) \) is within \(O(n\varepsilon)\) of \(\min _ {S: |S\cap \mathcal{T} _ X| \geq k} H(Y^n | X^n \in T)\) while it is also within \(O(n\varepsilon)\) insertions away from a product set \(S'\):

\begin{align}
        S' &= [\prod _ {i=1}^n s _ i] \cap \mathcal{T}^n _ \varepsilon(X), \\
        &\quad s _ i \subset \mathcal{X}, i\in [n], \\
	&\quad |S'| \in \exp(\log k \pm n\varepsilon)
\end{align}

and \(H(Y^n| X^n \in S')\leq H(Y^n|X^n\in T) + O(n\varepsilon)\).

With this form of \(S'\), what follows is a construction of \((U,Q)\) with \(Y-X-U\), \(H(U|Q) \leq H(X)-\frac{1}{n}\log k\) and \(Q\perp (X,Y)\).

-----

Derive sets from \(S'\) by permuting the dimensions of \(S'\): for \(\pi\) a permutation of \([n]\), take  

\begin{equation}
	S _ \pi := [\prod _ {i=1}^n s _ {\pi(i)}]\cap \mathcal{T}^n _ \varepsilon(X).
\end{equation}   

Then for a collection of \(\exp ( n (H(X)+\varepsilon) -\log k )\) randomly drawn permutations \(\{\pi _ \iota\} _ \iota\), the sets \(\{S _ {\pi _ \iota} \} _ \iota\) probably cover all but a negligible proportion of \(\mathcal{T}^n _ \varepsilon(X).\)  (see below [2]).

Write the projection onto dimension \(t\) as \(\tau _ t:\mathcal{X}^n\to \mathcal{X}\):

\begin{equation}
	\tau _ t\left( (x _ 1,\dots, x _ n) \right) := x _ t.
\end{equation}

As \(Q\) take \(n\) iid realizations according to the distribution of \(X\) and a random index \(j\): 

\begin{align}
	Q &:= (j,\ X _ {q,1},\dots, X _ {q,n}), \\
	&\quad X _ {q,i} \text{ iid } \sim X, \\ 
	&\quad j \sim \operatorname{Unif}[n].
\end{align}

Define \(f^\ast:\mathcal{X}^n\to [\exp (n(H(X)+\varepsilon)-\log k)]\) as:

\begin{equation}
	f^\ast(x _ 1,\dots, x _ n) := \iota \ni  (x _ 1,\dots, x _ n) \in S _ {\pi _ \iota}	
\end{equation} 

and an error symbol if no such \(\iota\) exists, breaking ties in a way that gives \(f^\ast\) level sets of product form:

\begin{equation}
	f^{\ast, -1}=\prod _ {t=1}^n v _ t, \quad v _ t \subset \mathcal{X}.
\end{equation} 

It is possible to break ties for \(f^\ast\) in this way because set differences between different \(S _ \pi\) are also of this product form.  Finally, define \(U\) as follows:

\begin{equation}
	U := \iota \ni (X _ {q,1}, \dots, X _ {q, j-1}, X, X _ {q, j+1}, \dots, X _ {q,n} )\in S _ {\pi _ \iota},
\end{equation}

Notice \(H(U|Q) \leq H(X)-\frac{1}{n}\log k + O(\varepsilon)\) but also \(H(Y|U,Q)\leq \frac{1}{n} H(Y|X\in S)+O(\varepsilon)\) (see below [3]). 
\(S\) is among the best choices for sets of its size, and we have found a single-letter \(U,Q\) which are within \(O(\varepsilon)\) of its performance characteristics.  
This completes the proof.

----

[1/4/2021]

Several technically involved details are glossed over near the end of the argument above. 

### [1]
This section was in an earlier version of the document I will have to rewrite.


### [2] 

> Then for a collection of \(\exp n (H(X)-\log k + \varepsilon)\) randomly drawn permutations \(\{\pi _ \iota\} _ \iota\), the sets \(\{S _ {\pi _ \iota} \} _ \iota\) probably cover all but a negligible proportion of \(\mathcal{T}^n _ \varepsilon(X).\) 

Include a description of the type of the sequence \(X^n\), (\(T^n _ X:\mathcal{X} \to [n]; \ T^n _ X(x) := |t:X _ t=x|\)), in the encoding \(f(X^n)\).  The amount of information needed to convey the type is negligible relative to \(nR\) so it can be included in the encoding without loss of generality. 
Conditioned on the type, the typical \(x^n\) are nothing more than all the permutations of sequences of that type (or empty for the unlikely case of an atypical sequence). 
 
Consider the set of permutations of \(N\) elements. Write it as \(\mathcal{P} _ N\). Also take any nonempty \(S\subset \mathcal{P} _ N \), thinking of \(S\) as similar to the \(S\) above. Consider that \(\{\pi \circ \pi': \pi \in \mathcal{P} _ N\} _ {\pi \in S}\) is an \(|S|\)-fold covering of \(\mathcal{P} _ N\), so the likelihood of picking \(M\) elements from this cover at random and the result not covering some \(\nu \in \mathcal{P} _ N\) is 

\begin{align}
	\log((1-|S|/N!)^M) &= \log(1-|S|/N!)M \\
	&= [-|S|/N! + O((|S|/N!)^2)]|M|
\end{align} 

which $\to -\infty$ if $|S|M/N!\to \infty$. So this claim holds.

### [3] 

> Notice \(H(U|Q) \leq H(X)-\frac{1}{n}\log k + O(\varepsilon)\) but also \(H(Y|U,Q)\leq \frac{1}{n} H(Y|X\in S)+O(\varepsilon)\).  

This follows due to a short lemma [here](https://ebn0.net/multivariate-function-reduction-to-single-letter-rvs.html), noting that \(H(Y|U,Q) = H(Y|X) + I(Y;X|U,Q) = H(Y|X) + H(X|U,Q) - H(X|U,Q,Y)\) and the lemma yields the necessary identity for the last two components.


