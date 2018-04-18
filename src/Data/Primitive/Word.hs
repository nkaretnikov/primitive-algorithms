{-# LANGUAGE MagicHash #-}

module Data.Primitive.Word
  ( toWord8#
  , fromWord8#
  ) where

import GHC.Prim
import GHC.Word

toWord8# :: Word8 -> Word#
toWord8# (W8# w) = w

fromWord8# :: Word# -> Word8
fromWord8# = W8#
