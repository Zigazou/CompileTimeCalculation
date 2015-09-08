{-# LANGUAGE TemplateHaskell #-}
import Prime

{- Because the generated list is a list of literal integers, GHC -Wall needs
   us to specify that `primeList` is a `List` of `Integer`s.
   `doPrimeQ` will be executed before the final compiling and its result inserted.
   For the rest of the program, primeList is the literal list of prime numbers
   [2,3,5,7,11,13,17,19,23,29,31,37...]. When the program is executed, `doPrimeQ`
   and `doPrime` won’t be executed.
-}
primeList :: [Integer]
primeList = $(doPrimeQ 0 40000)

{- The program just prints the number of prime numbers between 0 and 40000. As
   `primeList` has already been created, calculating its length is nearly
   instantaneous. Without TemplateHaskell, it would take several seconds.

   You should see 4203 printed!
-}
main :: IO ()
main = print $ length primeList
