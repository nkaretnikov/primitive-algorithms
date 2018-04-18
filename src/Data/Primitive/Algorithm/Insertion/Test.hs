module Data.Primitive.Algorithm.Insertion.Test
  ( test
  ) where

import Test.HUnit (Test(..), assertEqual)

import qualified Data.Primitive.Algorithm.Insertion as Insertion

test :: Test
test = TestList
  [ test0

  , test1

  , test2
  , test2SameOrder

  , test3
  , test3SameOrder

  , test4
  , test4SameOrder

  , test5
  , test5SameOrder
  ]


test0 :: Test
test0 = TestCase $ assertEqual "test0"
  [] =<< Insertion.sort []


test1 :: Test
test1 = TestCase $ assertEqual "test1"
  [7] =<< Insertion.sort [7]


test2 :: Test
test2 = TestCase $ assertEqual "test2"
  [3,9] =<< Insertion.sort [9,3]

test2SameOrder :: Test
test2SameOrder = TestCase $ assertEqual "test2SameOrder"
  [3,9] =<< Insertion.sort [3,9]


test3 :: Test
test3 = TestCase $ assertEqual "test3"
  [1,23,57] =<< Insertion.sort [23,1,57]

test3SameOrder :: Test
test3SameOrder = TestCase $ assertEqual "test3SameOrder"
  [1,23,57] =<< Insertion.sort [1,23,57]


test4 :: Test
test4 = TestCase $ assertEqual "test4"
  [4,13,40,100] =<< Insertion.sort [40,100,13,4]  

test4SameOrder :: Test
test4SameOrder = TestCase $ assertEqual "test4SameOrder"
  [4,13,40,100] =<< Insertion.sort [4,13,40,100]


test5 :: Test
test5 = TestCase $ assertEqual "test5"
  [3,34,90,92,255] =<< Insertion.sort [92,3,255,90,34]

test5SameOrder :: Test
test5SameOrder = TestCase $ assertEqual"test5SameOrder"
  [3,34,90,92,255] =<< Insertion.sort [3,34,90,92,255]
