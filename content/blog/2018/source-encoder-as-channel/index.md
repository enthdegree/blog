Title: Source Encoders as Channels
Date: 2018-04-06 2:50:00
Authors: Christian Chapman
Slug: source-encoder-as-channel
---

It is well known that a rate-distortion-optimal source encoder's output generally doesn't match its source's distribution. This can make some analyses a pain in the neck. For example, say you want to investigate the relationship between a signal that appears in a source, and that signal's appearance in an encoding of the source. You are forced to keep very close track of the encoder's statistical properties.

Fortunately for a rate-distortion optimal MMSE Gaussian source encoder, these properties can be made very simple. There is a way to rescale the encoder's output to make the source coding stage equivalent to adding independent Gaussian noise. In fact, a similar technique for "converting a rate-distortion source encoding into a channel" can probably be derived for other types of sources too. A description of the whole situation is given in this post.

Brief description of a rate-distortion encoder
--

The MMSE rate distortion function for a Gaussian source $X\sim\mathcal{CN}(0,\sigma^2)$ is 

\begin{equation}
	R(D) = \log_2\left(\frac{\sigma^2}{D}\right).
\end{equation}

Cover illustrates this is achievable in Theorem 10.3.2 of Elements of Information theory (albeit for real RVs). He does so by writing a "test channel" whose output is distributed like the source $X$:

\begin{equation}
	\hat{X} \longrightarrow 
	\mkern-2.2em \underset{\underset{\textstyle Z\sim \mathcal{N}(0,D)}{\big\uparrow}}{\oplus} \mkern-2.1em 
	\longrightarrow X.
\end{equation}

In the test channel, the input $\hat{X}$ characterizes the portion of the source that the encoding should preserve, and the channel's distortion (here the addition of an independent Gaussian noise $Z$) to be the part of the source that is not preserved. 

One first picks $2^{n\cdot(I(\hat{X};X)+\varepsilon)}$ length-$n$ codewords with components iid like $\hat{X}$ to form a codebook $\mathcal{C}$. Then the source coder forms its encoding by finding codeword in $\mathcal{C}$ that is jointly typical with the source. By design, this encoding relates to the source precisely in the way the test channel's input relates to its output.

Rescaling the encoding
--

For the Gaussian case above, we have

\begin{align}
	\phantom{\Rightarrow} E[(X-\hat{X})^2] &= D \\
	\Rightarrow E[X^2]+E[\hat{X}^2]-2E[X\hat{X}] &= D \\
	\Rightarrow \sigma^2+\sigma^2-D-2\mathrm{Cov}(X,\hat{X}) &= D \\
	\Rightarrow \mathrm{Cov}(X,\hat{X}) = \sigma^2-D
\end{align}

so source estimates using this test channel encoder have approximately the following joint-distribution with the source:

\begin{equation}
	(X,\hat{X})\sim \mathcal{CN}\left(\vec{0}, 
		\left[\begin{smallmatrix}\sigma^2 & \sigma^2-D \\ \sigma^2-D & \sigma^2-D\end{smallmatrix}\right]\right).
\end{equation}

If we rescale the encoding by $\alpha$, the joint distribution becomes:

\begin{align}
	(X,\alpha \cdot \hat{X}) &\sim \mathcal{CN}\left(\vec{0}, 
		\left[\begin{smallmatrix}1 & \\ & \alpha\end{smallmatrix}\right]
		\left[\begin{smallmatrix}\sigma^2   & \sigma^2-D \\ \sigma^2-D & \sigma^2-D \end{smallmatrix}\right]
		\left[\begin{smallmatrix}1 & \\ & \alpha\end{smallmatrix}\right]\right) \\
	&\sim \mathcal{CN}\left(\vec{0}, 
	\left[\begin{smallmatrix}\sigma^2   & \alpha \cdot (\sigma^2-D) \\ \alpha\cdot (\sigma^2-D) & \alpha^2\cdot (\sigma^2-D) \end{smallmatrix}\right]\right).
\end{align}

Choosing $\alpha=\frac{\sigma^2}{\sigma^2-D},$ the covariance matrix becomes:

\begin{align}
	\left[\begin{smallmatrix}\sigma^2   & \sigma^2 \\ \sigma^2 & \frac{\sigma^4}{\sigma^2-D} \end{smallmatrix}\right]= \left[\begin{smallmatrix}\sigma^2   & \sigma^2 \\ \sigma^2 & \sigma^2+\frac{\sigma^2\cdot D}{\sigma^2-D} \end{smallmatrix}\right].
\end{align}

so this rate-distortion encoding process down to distortion $D$ can be seen as equivalent to adding independent Gaussian noise with power $\frac{\sigma^2\cdot D}{\sigma^2-D}$.

Similarly, if our choice of encoder instead involves setting a rate in the Gaussian distortion-rate function $D(R)=\sigma^2\cdot 2^{-R}$, then source encoding can be viewed as adding independent Gaussian noise with power $\frac{\sigma^2}{2^R-1}.$

-----

All we have done here is the following:

 1. Identify the test channel used to construct the rate-distortion-optimal encoder for the source.
 2. Written down the joint-distribution between the test channel's input and output, $P_{\hat{X},X}$.
 3. Factor the joint distribution as: $P_X\cdot P_{\hat{X}|X}$ and identify that after source encoding, $P_{\hat{X}|X}$ is the "channel" through which you see the source $X$.
 4. Identify some processing on the channel output that makes the joint distribution $P_{\hat{X}|X}$ more obvious (in our case scaling by $\alpha$).

The same idea can probably be repeated for non-Gaussian channels too, as long as the test channel is easy enough to analyze and 'reverse.'
