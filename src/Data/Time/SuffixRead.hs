--------------------------------------------------------------------------------
-- Suffix Time Reader Library                                               --
--------------------------------------------------------------------------------
-- This source code is licensed under the BSD3 licence found in the LICENSE   --
-- file in the root directory of this source tree.                            --
--                                                                            --
-- Copyright 2020 Oscar Harris (oscar@oscar-h.com)                            --
--------------------------------------------------------------------------------
module Data.Time.SuffixRead (
    ReadSuffixTime,
    readSuffixTime
) where

-- An instance of this typeclass can be read
class ReadSuffixTime a where
    readSuffixTime :: String -> Maybe a

instance ReadSuffixTime Int where
    readSuffixTime = undefined
