{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

-- | This module is intended to be imported 'qualified':
--
-- import Data.Primitive.ByteArray (BA (..))
-- import qualified Data.Primitive.ByteArray as BA

module Data.Primitive.ByteArray
  ( BA (..)
  , length
  , index
  , unpack
  ) where

import Prelude hiding (length)
import GHC.Prim
import GHC.Types
import GHC.Word

-- XXX: Support other types, perhaps use backpack.

-- Based on 'ghc/testsuite/tests/lib/integer/integerGmpInternals.hs'.
data BA = BA { unBA  :: !ByteArray# }

length :: ByteArray# -> Word
length ba = W# (int2Word# (sizeofByteArray# ba))

index :: ByteArray# -> Word -> Word8
index arr (W# n) = W8# (indexWord8Array# arr (word2Int# n))

unpack :: ByteArray# -> [Word8]
unpack ba
  | n == 0    = []
  | otherwise = [ index ba i | i <- [0 .. n-1] ]
  where
    n = length ba
