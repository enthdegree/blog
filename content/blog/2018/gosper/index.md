Title: Combinatoral Iteration in Matlab
Date: 2018-2-23 1:50:00
Authors: Christian Chapman
Slug: gosper
---

Often we need a to write a program that iterates over all combinations of $k$ elements from some set (elements chosen without replacement). It isn't obvious how to efficiently traverse through all these sets, although if bitwise arithmetic is readily available one can use [Gosper's Hack](https://en.wikipedia.org/wiki/Combinatorial_number_system#Applications). This kind of problem comes up quite commonly in Matlab with all its use in scientific prototyping, but the necessary bitwise operations for Gosper's hack aren't easily accessible here without special toolboxes. I have written an iterator for Matlab that works around this nuisance: 

## **[gosper.m](https://github.com/enthdegree/gosper.m)**.

A few improvements could be useful: 

- Too much time is spent on unnecessary conversion. The only reason the converters `fn_bv2n`, `fn_n2bv` are used is that in Matlab it happens to be way more straightforward to perform binary array addition (line 48) and right-shifts (line 58) by converting to a decimal, doing decimal math, then converting back to a binary vector than it is to implement these operations properly. 
- Interface could be improved. Flags could be added for big/little-endianness, output format (binary vector or number), and whether or not to throw an error if there are no more sets of size $k$ left, rather than just going straight to the next size.

On the other hand, this code is probably robust enough for most applications. My old laptop finishes over 7000 iterations per second on sets of size 100 which (perhaps alarmingly) seems decent for Matlab.
