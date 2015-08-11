module Test.Main where

import Prelude

import Debug
import Debug.Console (debug)

import Control.Monad.Eff.Console

gcd :: Int -> Int -> Debug Int
gcd 0 m = return m
gcd n 0 = return n
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

main = debug (gcd 242 12)
