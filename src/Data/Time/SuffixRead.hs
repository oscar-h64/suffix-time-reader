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

import Control.Monad.Writer
import Text.Read ( readMaybe )

-- Multipliers for each suffix
timeMults :: [(Char, Int)]
timeMults = [
        ('s',     1),
        ('m',    60),
        ('h',  3600),
        ('d', 86400)
    ]

-- | `splitEnd` @ls@ attempts to split the last element and the elements 
--    before it. If this fails Nothing is returned
splitEnd :: [a] -> Maybe (a, [a])
splitEnd []  = Nothing
splitEnd ls  = pure $ runWriter $ splitEnd' ls
    where
        splitEnd' :: [a] -> Writer [a] a
        splitEnd' [x]    = pure x
        splitEnd' (x:xs) = tell [x] >> splitEnd' xs

-- An instance of this typeclass can be read to
class ReadSuffixTime a where
    readSuffixTime :: String -> Maybe a

-- This instance reads to an Int representing the number of seconds
instance ReadSuffixTime Int where
    readSuffixTime s = do
        (lastElem, initElems) <- splitEnd s
        num <- readMaybe initElems
        mult <- lookup lastElem timeMults
        pure $ num * mult
