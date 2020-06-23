--------------------------------------------------------------------------------
-- Suffix Time Reader Library                                               --
--------------------------------------------------------------------------------
-- This source code is licensed under the BSD3 licence found in the LICENSE   --
-- file in the root directory of this source tree.                            --
--                                                                            --
-- Copyright 2020 Oscar Harris (oscar@oscar-h.com)                            --
--------------------------------------------------------------------------------
{-# LANGUAGE ScopedTypeVariables #-}

import Data.Time.Clock
import Data.Time.SuffixRead

import Test.Tasty
import Test.Tasty.QuickCheck

tests :: TestTree
tests = localOption (Timeout (5*1000000) "5s") $ testGroup "Data.Time.SuffixReader.readSuffixTime" 
    [
        testProperty "returns Nothing on invalid input" $ 
            \x -> (readSuffixTime x :: Maybe Int) === Nothing
    ,   testProperty "reads seconds to Int correctly" $ 
            \(x :: Int) -> (readSuffixTime (show x ++ "s") :: Maybe Int) === Just x
    ,   testProperty "reads minutes to Int correctly" $ 
            \(x :: Int) -> (readSuffixTime (show x ++ "m") :: Maybe Int) === Just (x * 60)
    ,   testProperty "reads hours to Int correctly" $ 
            \(x :: Int) -> (readSuffixTime (show x ++ "h") :: Maybe Int) === Just (x * 3600)
    ,   testProperty "reads days to Int correctly" $ 
            \(x :: Int) -> (readSuffixTime (show x ++ "d") :: Maybe Int) === Just (x * 86400)
    ,   testProperty "reads seconds to DiffTime correctly" $ 
            \(x :: Integer) -> (readSuffixTime (show x ++ "s") :: Maybe DiffTime) === Just (secondsToDiffTime x)
    ,   testProperty "reads minutes to DiffTime correctly" $ 
            \(x :: Integer) -> (readSuffixTime (show x ++ "m") :: Maybe DiffTime) === Just (secondsToDiffTime $ x * 60)
    ,   testProperty "reads hours to DiffTime correctly" $ 
            \(x :: Integer) -> (readSuffixTime (show x ++ "h") :: Maybe DiffTime) === Just (secondsToDiffTime $ x * 3600)
    ,   testProperty "reads days to DiffTime correctly" $ 
            \(x :: Integer) -> (readSuffixTime (show x ++ "d") :: Maybe DiffTime) === Just (secondsToDiffTime $ x * 86400)
    ]

main :: IO ()
main = defaultMain tests
