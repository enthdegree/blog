Title: A Class of Multivariate Functions that Behave Like Single-Letter Random Variables
Date: 2020-12-30 13:00:00
Modified: 2021-1-4 13:00:00
Authors: Christian Chapman
Slug: multivariate-function-reduction-to-single-letter-rvs
---

Vector-encoders of a certain pretty restricted class happen to carry the same information content as univariate encoders.  This turns out to be relevant to an aspect of [time-expanded information bottlenecks](https://ebn0.net/extracting-relevant-information.html). 

### Claim 

> Take $X _ 1,\dots, X _ n$ iid over finite alphabet \(\mathcal{X}\) and \(f:\mathcal{X}^n \to \mathbb{N}\) with level sets of the form:

> \begin{align}
	f^{-1}(i) = \prod _ {t=1}^n s _ t ,\ s _ t \subseteq \mathcal{X}^n \forall t\in [n], \  \forall i\in \mathbb{N}.
\end{align} 
> 
> Then for \(T\) picked uniformly at random from \([n],\) 
 
> \begin{align}
	H\left(f(X _ 1,\dots, X _ n) | T, (X _ t) _ {t \neq T} \right) &= \frac{1}{n} H\left( f(X _ 1,\dots, X _ n) \right) \text{ and }\\
	H\left(X _ T | f(X _ 1,\dots, X _ n), (X _ t) _ {t \neq T}, T\right) &= \frac{1}{n} H \left( X _ 1, \dots, X _ n | f(X _ 1, \dots, X _ n) \right).
\end{align}

> Further if there are some \(Y _ 1, \dots, Y _ n\) with each of \((X _ t, Y _ t) _ {t\in [n]}\) jointly iid then also 

> \begin{align}
	H \left( X _ T | f(X _ 1,\dots, X _ n), (X _ t, Y _ t) _ {t \neq T}, T, Y _ T \right) &= \frac{1}{n} H \left( X _ 1, \dots, X _ n | f(X _ 1, \dots, X _ n), ( Y _ 1, \dots, Y _ n ) \right).
\end{align}

The idea to create a single-letter encoder out of the vector-input \(f:\mathcal{X}^n\to \mathbb{N}\) is to generate \(n-1\) "synthetic" iid source variables and a random index $T$. Then one can form a $n$-vector input for $f$ by inserting the actual single source observation as \(T\). The claim demonstrates this strategy gives a single-letter encoder that behaves like the vector encoder in three ways up to entropy (similar in encoding rate, similar in amount of source information provided, similar in amount of source information provided in the presence of side information).

### Proof

First notice that using entropy identities,

\begin{align}
	H\left(X _ T | f(X _ 1,\dots, X _ n), (X _ t) _ {t \neq T}, T\right) &= H(X _ T | (X _ t) _ {t \neq T}, T) - I\left(X _ T; f(X _ 1,\dots, X _ n) | (X _ t) _ {t \neq T}, T\right) \\
	&= H(X _ T) - [H(X _ T) + H\left(f(X _ 1,\dots, X _ n) | (X _ t) _ {t \neq T}, T\right) - H\left( f(X _ 1,\dots, X _ n), X _ T | (X _ t) _ {t \neq T}, T\right)] \\ 
	&= H( X _ T ) - H\left(f(X _ 1,\dots, X _ n) | (X _ t) _ {t \neq T}, T\right) \\ 
	&= \frac{1}{n} H( X _ 1, \dots, X _ n ) - H\left(f(X _ 1,\dots, X _ n) | (X _ t) _ {t \neq T}, T\right). \tag{\(\ast\)}
\end{align}

If the first equality in the claim is true then:

\begin{align}
	(\ast) &= \frac{1}{n} H( X _ 1, \dots, X _ n ) - \frac{1}{n} H\left( f(X _ 1,\dots, X _ n) \right) \\
	&= \frac{1}{n} H\left( X _ 1, \dots, X _ n  | f(X _ 1,\dots, X _ n) \right). 
\end{align}

So really the essential part of this claim is the first equality. 

For each \(\iota \in \operatorname{Range} f,\) label the components of level sets of \(f\) as \(\{s _ {\iota,t}\} _ {t\in [n]}\) as so: 

\begin{equation}
	\{(x _ t) _ {t\in [n]} : f( x _ 1, \dots, x _ t) = \iota\} = \prod _ {t = 1}^n s _ {\iota, t} 
\end{equation} 

with each \(s _ {\iota, t} \subset \mathcal{X}\). Now compute (with the convention \((-0\log 0) = 0\)):

\begin{align}
	H\left( f(X _ 1,\dots, X _ n) | T, (X _ t) _ {t \neq T} \right) &= \sum _ {t=1}^n \frac{1}{n} H\left( f(X _ 1,\dots, X _ n) | T=t, (X _ t) _ {t \neq T} \right) \\
	&= \sum _ {t=1}^n \sum _ {(x _ i) _ {i \neq t}} \frac{1}{n} P((X _ i) _ {i \neq T}=(x _ i) _ {i\neq t}) H\left( f(X _ 1,\dots, X _ n) | T=t, (X _ i) _ {i \neq T}=(x _ i) _ {i\neq t} \right) \\
	&= \frac{1}{n} \sum _ {t=1}^n \sum _ {(x _ i) _ {i \neq t}} P((X _ i) _ {i \neq T}=(x _ i) _ {i\neq t}) \sum _ \iota (-p\log p)| _ {p = P \left( f(X _ 1,\dots, X _ n) = \iota | T=t, (X _ i) _ {i \neq T}=(x _ i) _ {i\neq t} \right)} \\
	&= \frac{1}{n} \sum _ {t=1}^n \sum _ {(x _ i) _ {i \neq t}} P((X _ i) _ {i \neq T}=(x _ i) _ {i\neq t}) \sum _ \iota \mathbb{1} _ {(x _ i) _ {i \neq t} \in (s _ {\iota, i}) _ {i \neq t} }  (-p\log p)| _ {p = P(X _ t \in s _ {\iota, t})} \\
	&= \frac{1}{n} \sum _ \iota \sum _ {t=1}^n \sum _ {(x _ i) _ {i \neq t} \in (s _ {\iota, i}) _ {i \neq t}} P((X _ i) _ {i \neq T}=(x _ i) _ {i\neq t}) (-p\log p)| _ {p = P(X _ t \in s _ {\iota, t})}  \\
	&= \frac{1}{n} \sum _ \iota \sum _ {t=1}^n -P((X _ i) _ {i \in [n]} \in (s _ {\iota, i}) _ {i \in [n]}) \log P(X _ t \in s _ {\iota, t}) \\
	&= \frac{1}{n} \sum _ \iota -P((X _ i) _ {i \in [n]} \in (s _ {\iota, i}) _ {i \in [n]}) \prod _ {t=1}^n \log P(X _ t \in s _ {\iota, t}) \\
	&= \frac{1}{n} \sum _ \iota -P((X _ i) _ {i \in [n]} \in (s _ {\iota, i}) _ {i \in [n]}) \log P(X _ {i \in [n]} \in \prod _ {i \in [n]} s _ {\iota, i}) \\
	&= \frac{1}{n} H(f(X _ 1, \dots, X _ n)).
\end{align}

Thus we have the first two equalities. 

The claim's third equality follows by applying the second equality to the sequence of random variables \((X _ t, Y _ t) _ {t\in [n]}\) and the function \(f^\ast : \mathcal{X}^n \times \mathcal{Y}^n \to \mathbb{N}\times \mathcal{Y}^n;\ f^\ast((X _ t, Y _ t) _ {t\in [n]}) := \left(f( (X _ t) _ {t\in [n]}  ),\ ( Y _ t ) _ {t \in [n]} \right)\):

\begin{align}
	H\left(X _ T, Y _ T  | f^\ast(X _ 1,\dots, X _ n), (X _ t, Y _ t) _ {t \neq T}, T\right) &= \frac{1}{n} H \left( (X _ t, Y _ t) _ {t \in [n]} | f^\ast(X _ 1, \dots, X _ n) \right) \\ 
	H\left(X _ T, Y _ T | f(X _ 1,\dots, X _ n), Y _ T, (X _ t, Y _ t) _ {t \neq T}, T\right) &= \frac{1}{n} H \left( (X _ t, Y _ t) _ {t \in [n]} | f(X _ 1, \dots, X _ n), ( Y _ t ) _ {t \in [n]} \right) \\ 
	H\left(X _ T | f(X _ 1,\dots, X _ n), (Y _ t) _ {t \in [n]}, (X _ t) _ {t \neq T}, T\right) &= \frac{1}{n} H \left( (X _ t) _ {t \in [n]} | f(X _ 1, \dots, X _ n), ( Y _ t ) _ {t \in [n]} \right).  
\end{align}

