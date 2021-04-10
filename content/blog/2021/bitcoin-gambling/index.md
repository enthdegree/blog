Title: Some Naive Thoughts on Bitcoin Gambling: Hold or Sell?
Date: 2021-2-20
Modified: 2021-2-20
Authors: Christian Chapman
Slug: bitcoin-gambling
-----

I own some bitcoin and I intend to hold for a really long time. 
The total value of my crypto holdings is small enough that I would be OK with it losing all of it, but I would really prefer it to grow instead.

There are moments when I believe the market is at a precipice and bitcoin price is about to either skyrocket or fall off a cliff but I'm not sure which.
Often the amount I believe it might boom is asymmetric to how much I believe it might crash.

> When belief for the two possible outcomes is asymmetric, how should one move money between BTC and USD to retain the most expected value?

I am really risk-averse and don't want to put any more value into BTC than I already am, so instead I'll instead ask this quesiton:

> Say $\ell$ is the event of a loss. Holding $E[\text{Profit}|\ell]$ fixed at some tolerable negative value, how should I move money between USD and BTC to maximize expected profit?

Here's an Octave script that calculates this for you: 

> [bitcoin_gambler.tar.gz](blog/2021/bitcoin-gambling/bitcoin_gambler.tar.gz)

The math is fairly elementary and you can follow along through the scripts. 

 - Includes Coinbase's percent transaction fees
 - Models a boom or dip as happening with equal probability 
 - Models them as following a max entropy distribution within specified means and bounds according to market belief. ([Link to MathOverflow](https://mathoverflow.net/questions/116667/)).

It's common knowledge that gambling doesn't pay off and that determining when you aren't gambling is itself extremely technical and complicated. 
On the other hand, these basic principles are probably better to operate on than pure emotions, so they're what I'm going with. 
For most of my market beliefs this script typically tells me to convert it back to USD...


