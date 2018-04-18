{-# LANGUAGE RecordWildCards #-}

module Main where

import System.Exit (exitFailure, exitSuccess)
import Test.HUnit (runTestTT, Test(..), Counts(..))
import qualified Data.Primitive.Algorithm.Insertion.Test as Insertion

main :: IO ()
main = do
  Counts {..} <- runTestTT $ TestList [Insertion.test]
  if any (/= 0) [errors, failures]
  then exitFailure
  else exitSuccess
