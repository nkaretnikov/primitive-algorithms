{-# LANGUAGE MagicHash #-}

module Data.Primitive.Algorithm.Insertion
  ( sort
  ) where

import Prelude
import GHC.Word

import Data.Primitive.ByteArray (BA (..))
import qualified Data.Primitive.ByteArray as BA
import Data.Primitive.MutableByteArray (MBA (..))
import qualified Data.Primitive.MutableByteArray as MBA

{-
From "The Algorithm Design Manual" by Steven S Skiena:

insertion_sort(item s[], int n)
{
    int i,j;                /* counters */
    for (i=1; i<n; i++) {
       j=i;
       while ((j>0) && (s[j] < s[j-1])) {
           swap(&s[j],&s[j-1]);
           j = j-1;
       }
    }
}
-}

-- XXX: Support other types, perhaps use backpack.
sort :: [Word8] -> IO [Word8]
sort s = do
  let n = length s
  BA ba <- do
    MBA mba <- MBA.init s (toEnum n)
    for 1 (+ 1) (\i -> return $ i < n) $ \i -> do
      -- print $ "i: " ++ show i
      for i (\j -> j - 1) (\j -> do
        sj   <- MBA.index mba j
        sj_1 <- MBA.index mba (j - 1)
        return (j > 0 && (sj < sj_1))) $ \j -> do
          -- print $ "j: " ++ show j
          MBA.swap mba j (j - 1)
    MBA.freeze mba
  return (BA.unpack ba)

-- XXX: 'IO ()' can be generalized to 'IO a'.
for :: Int -> (Int -> Int) -> (Int -> IO Bool) -> (Int -> IO ()) -> IO () 
for i f p act = do
  b <- p i
  if b
  then act i >> for (f i) f p act
  else return ()
