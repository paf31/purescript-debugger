module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Debug.Console (READLINE, CONSOLE, EXCEPTION, Debug, watch, break, debug)

gcd :: Int -> Int -> Debug Int
gcd 0 m = pure m
gcd n 0 = pure n
gcd n m
  | n > m = do
      break do
        watch "n" n
        watch "m" m
      gcd (n - m) m
  | otherwise = do
      break do
        watch "n" n
        watch "m" m
      gcd n (m - n)

main :: forall eff. Eff ( readline :: READLINE
                        , console :: CONSOLE
                        , exception :: EXCEPTION
                        | eff
                        ) Unit
main = debug (gcd 242 12)
