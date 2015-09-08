module Prime where
import Language.Haskell.TH.Syntax

{- `doPrime` is a function which finds every prime numbers between `start` and
   `end`. As it is very time consuming, it is easy to notice when it is executed
   (either at compile time or at runtime).
-}
doPrime :: Integer -> Integer -> [Integer]
doPrime start end
    | curr > end = []
    | otherwise = curr : doPrime (curr + 1) end
    where
        curr :: Integer
        curr = nextPrime start

        isPrime :: Integer -> Bool
        isPrime 0 = False
        isPrime 1 = False
        isPrime k = 0 `notElem` map (mod k) [2 .. k - 1]

        nextPrime :: Integer -> Integer
        nextPrime i | isPrime i = i
                    | otherwise = nextPrime (i + 1)


{- The `doPrimeQ` function generates an AST subtree which can be inserted by the
   compiler into the final AST. Every element of the AST is defined in
   `Language.Haskell.TH.Syntax`. For example, `[1, 2, 3]`, an `[Integer]`
   structure, is represented as
   `ListE [LitE (IntegerL 1),LitE (IntegerL 2),LitE (IntegerL 3)]`. We could
   generate this `Exp` value like in the first (commented) version of `doPrimeQ`.
   But TemplateHaskell has the `lift` function which does the job for us, as long
   as the type we want to convert to an `Exp` is an instance of the `Lift` class.
   For standard types, like our `[Integer]`, it is the case.
-}
-- doPrimeQ :: Integer -> Integer -> Q Exp
-- doPrimeQ n m = return $ ListE $ (LitE . IntegerL) <$> doPrime n m

doPrimeQ :: Integer -> Integer -> Q Exp
doPrimeQ start end = lift $ doPrime start end