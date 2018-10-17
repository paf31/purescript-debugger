module Test.Main where

import Prelude

import Debug.Console (Debug, watch, break, debug)
import Effect (Effect)

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

main :: Effect Unit
main = debug (gcd 242 12)
