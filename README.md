CompileTimeCalculation
=====================

CompileTimeCalculation is a simple program written in Haskell which demonstrates how
to do compile-time calculation using TemplateHaskell.

It uses a simple prime numbers function `doPrime` just to make you notice when the
computation really occurs (during compilation or during execution).

In order for the result of `doPrime` to be inserted directly into our program, the
function needs to be encapsulated in a `doPrimeQ` function. This function converts
the output of `doPrime` to an AST subtree suitable for the `$()` notation.

The program itself will take more time to compile than to execute. When it runs,
it should just print 4203 (the number of prime numbers between 0 and 40000).

The source code is split into 2 files. This is required by TemplateHaskell.
`doPrimeQ` needs to be already compiled when it is executed by the `$()` call.

The source code is commented to help you understand how it works.