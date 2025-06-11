# Transform

## Attention Mechanism

The fundamental concepts that underpins Transformer is *Attention*.
This was originally developed as an enhance to RNN for machine translation.
However, researcher later showed that significant improved performence can be obtained by 
eliminating recurrence structure and instead focusing exclusively on the attention mechanism.
Today, Transformers based on attention mechnism have completely superseded RNN in almost all applications.

We will motivate the use of transformer by using natural langurage as a example.
Consider the following two sentences:

1. I **swam** across the **river** to get to the other **bank**
2. I walked across the **road** to get cash from the **bank**.

Here the word 'bank' has different meanings in the two sentence.
However this can be detected by looking at the context provided by other words at the squence.
We also see that some words is more important than others in determining the interpretation of the word 'bank'.
In the first sentence, the words 'swam' and 'river' most strongly indicate that the word 'bank' refers to the side of a river,

