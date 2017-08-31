{-
    File: Proj1.hs
    Author: Abhineet Gupta (719080)
    Purpose: Project 1
    Subject: COMP90048 Declarative Programming
    Context: Semester 2, 2017; UniMelb
-}

module Proj1 (initialGuess, nextGuess, GameState) where

    import Data.List

    -- store the game state as a list of chords (3 strings) that COULD be the answer
    data GameState = GameState [[String]]
        deriving (Show)

    -- provide an initial guess for the game
    initialGuess    ::  ([String], GameState)
    initialGuess = (["A1","B2","C3"], GameState [["A1","B2","C4"]])

    -- provide a next guess in the game based on the previous feedback
    nextGuess       ::  ([String], GameState) -> (Int, Int, Int) -> ([String], GameState)
    nextGuess _ _ = (["A1","B2","C3"], GameState [["A1","B2","C4"]])

    -- Compare target and guess strings and provide a 3-tuple response...
    -- ...of the correct pitch, note and octave respectively.
    feedback :: [String] -> [String] -> (Int, Int, Int)
    feedback target guess = (pitch, note, octave)
        where   pitch = length (intersect target guess)
                note = 3 - pitch - length (deleteFirstsBy (\p1 -> \p2 -> (p1 !! 0) == (p2 !! 0)) guess target)
                octave = 3 - pitch - length (deleteFirstsBy (\p1 -> \p2 -> (p1 !! 1) == (p2 !! 1)) guess target)
