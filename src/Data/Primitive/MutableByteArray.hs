{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

-- | This module is intended to be imported 'qualified':
--
-- import Data.Primitive.MutableByteArray (MBA (..))
-- import qualified Data.Primitive.MutableByteArray as MBA

module Data.Primitive.MutableByteArray
  ( MBA (..)
  , new
  , init
  , write
  , swap
  , index
  , freeze
  ) where

import Prelude hiding (init)
import Control.Monad (forM_)
import GHC.Prim
import GHC.Types
import GHC.Word

import Data.Primitive.ByteArray (BA (..))
import Data.Primitive.Int

-- XXX: Support other types, perhaps use backpack.

-- Based on 'ghc/testsuite/tests/lib/integer/integerGmpInternals.hs'.
data MBA = MBA { unMBA :: !(MutableByteArray# RealWorld) }

new :: Word# -> IO MBA
new sz = IO $ \s ->
  case newPinnedByteArray# (word2Int# sz) s of
    (# s', arr #) -> (# s', MBA arr #)

init :: [Word8] -> Word -> IO MBA
init xs (W# n) = do 
  MBA mba <- new n
  let n' = fromInt# (word2Int# n)
  forM_ (zip [0..n'-1] xs) $ \(i, w) ->
    write mba i w
  return (MBA mba)

write :: MutableByteArray# RealWorld -> Int -> Word8 -> IO ()
write arr (I# i) (W8# w) = IO $ \s ->
  case writeWord8Array# arr i w s of
    s' -> (# s', () #)

swap :: MutableByteArray# RealWorld -> Int -> Int -> IO ()
swap arr (I# i) (I# j) = IO $ \s ->
  case readWord8Array# arr i s of
    (# s', wi #) -> case readWord8Array# arr j s' of
      (# s'', wj #) -> case writeWord8Array# arr j wi s'' of
        s''' -> (# writeWord8Array# arr i wj s''', () #)

index :: MutableByteArray# RealWorld -> Int -> IO Word8
index arr (I# i) = IO $ \s ->
  case readWord8Array# arr i s of
    (# s', wi #) -> (# s', W8# wi #)

freeze :: MutableByteArray# RealWorld -> IO BA
freeze arr = IO $ \s ->
  case unsafeFreezeByteArray# arr s of
    (# s', arr' #) -> (# s', BA arr' #)
