{-# LANGUAGE MagicHash #-}

module Data.Primitive.Int
  ( toInt#
  , fromInt#
  ) where

import GHC.Prim
import GHC.Types

toInt# :: Int -> Int#
toInt# (I# i) = i

fromInt# :: Int# -> Int
fromInt# = I#
