Title: Some Interaction Information Examples
Date: 2017-10-11 2:50:00
Authors: Christian Chapman
Slug: interaction-info-examples
---

Interaction information between three random variables has a much less immediate interpretation compared to other information quantities. This makes it more tricky to work with. An i.i. term $I(X;Y;Z)$ between $X,\ Y$ and $Z$, could be either negative: 
> If we are trying to specify $X$ with $Y$ and $Z$, we expect $Z$ to mostly be redundant to part of $Y$

or positive:

> If we are trying to specify $X$ with $Y$ and $Z$, we expect $Z$ to mostly *add new information* to that from $Y$. 

(Interaction information is commutative in its arguments, so the variable's can be switched around in these interpretations.)

 Knowing how the joint distribution of $(X,Y,Z)$ factors can tell you whether an interaction information is positive or negative. Here are two simple and useful cases.

Negative: $X\rightarrow Y \rightarrow Z$ is a Markov chain
---
In this situation, $P_{(X,Y,Z)}=P_X\cdot P_{Y|X}\cdot P_{Z|Y}.$
Then $I(X;Y)\geq I(X;Y|Z)$ so $I(X;Y;Z)\leq 0.$

An easy example of such variables is $X=(A_1,A_2,A_3), Y=(A_1,A_2), Z=A_1$ for any random $A_i$.


Positive: $X\perp Y$ and $Z$ is derived from $X$ and $Y$
---
In this situation, $P_{(X,Y,Z)}=P_X\cdot P_Y\cdot P_{Z|(X,Y)}.$
Notice that $H(X)=H(X|Y),$ and that $H(X|Z)\geq H(X|Y,Z).$
Then $I(X;Z) \leq I(X;Z|Y)$ so $I(X;Y;Z)\geq 0.$

A trivial example is any $X\perp Y$ and $Z=(X,Y).$ A more interesting one is $N_1,N_2$ iid $\sim\mathcal{N}(0,1)$ with $X=N_1+N_2,\ Y=N_1-N_2$ and $Z=N_1.$
