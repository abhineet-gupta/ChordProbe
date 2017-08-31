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
        -- enumerate all possible gamestates
        -- return one as guess
    initialGuess = (["A1","B2","C3"], GameState chords) where
        chords = [[a,b,c] | a <- pitch, b <- pitch, c <- pitch, a < b, b < c]
        pitch = [[n, o] | n <- ['A'..'G'], o <- ['1'..'3']]

    -- provide a next guess in the game based on the previous feedback
    nextGuess       ::  ([String], GameState) -> (Int, Int, Int) -> ([String], GameState)
    -- for all remaining guesses, calculate 
    
    nextGuess (pg, GameState s) (cor, not, oct) = (gss, newGameState) where
        newGameState = GameState updatedChords
        updatedChords = delChord s pg
        gss = updatedChords !! 0


    -- Compare target and guess strings and provide a 3-tuple response...
    -- ...of the correct pitch, note and octave respectively.
    feedback :: [String] -> [String] -> (Int, Int, Int)
    feedback target guess = (pitch, note, octave)
        where   pitch = length (intersect target guess)
                note = 3 - pitch - length (deleteFirstsBy (\p1 -> \p2 -> (p1 !! 0) == (p2 !! 0)) guess target)
                octave = 3 - pitch - length (deleteFirstsBy (\p1 -> \p2 -> (p1 !! 1) == (p2 !! 1)) guess target)

    -- unpack GameState
    getState :: GameState -> [[String]]
    getState (GameState x) = x

    -- delete a chord from list of chords
    delChord :: [[String]] -> [String] -> [[String]]
    delChord (x:xs) y
        | null (x \\ y) = xs
        | otherwise = x : delChord xs y