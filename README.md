# suffix-time-reader

![Haskell CI](https://github.com/oscar-h64/suffix-time-reader/workflows/Haskell%20CI/badge.svg)

This library provides a single module `Data.Time.SuffixRead` which contains a typeclass `ReadSuffixTime`. This typeclass has a single function:
```haskell
readSuffixTime :: String -> Maybe a
```

This function takes a suffixed time such as "30m" (acceptable suffixes are `s` (seconds), `m` (minutes), `h` (hours) and `d` (days)) and converts it type `a`. An instance is provided for `Num a` which includes `DiffTime` and `NominalDiffTime`. For other types `Num a` then `readSuffixTime` returns the number of seconds 
