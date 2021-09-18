{-# LANGUAGE DerivingVia #-}

module Lib where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

class MyMonoid a where
  z :: a
  c :: a -> a -> a

newtype SumInt = SumInt Int
  deriving (Eq, Show)
  deriving (Num) via Int

instance MyMonoid SumInt where
  z = SumInt 0
  c = (+)
