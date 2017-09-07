{-
    File:       Proj1.hs
    Author:     Abhineet Gupta (719080)
    Purpose:    Project 1 [ChordProbe]
    Subject:    COMP90048 Declarative Programming
    Context:    Semester 2, 2017; UniMelb

    Usage:      Make using `ghc -O2 --make Proj1Test`
                Run by supplying chord e.g. `./Proj1Test A1 B2 C3`
    
    Descr:      In the game of ChordProbe, this program performs...
                ...the role of the 'performer' and guesses the ...
                ...correct 3-pitch chord while receiving feedback...
                ...from the composer.
-}

module Proj1 (initialGuess, nextGuess, GameState) where

    import Data.List
    import Data.Maybe

    -- store the game state as a list of potential chords (3 strings)
    data GameState = GameState [[String]]
        deriving (Show)

    -- provide an initial guess for the game
    initialGuess :: ([String], GameState)
        -- enumerate all possible gamestates and return one as guess
    initialGuess = (["A1","B2","C3"], GameState chords) where
        chords = [[a,b,c] | a <- pitch, b <- pitch, c <- pitch, a < b, b < c]
        pitch = [[n, o] | n <- ['A'..'G'], o <- ['1'..'3']]


    -- provide a next guess in the game based on the previous feedback
    nextGuess :: ([String], GameState) -> (Int, Int, Int) -> 
        ([String], GameState)
    nextGuess (pg, GameState s) score = (gss, newGameState) where
        newGameState = GameState updatedChords
        updatedChords = delChord' s pg score
        gss = pickOne updatedChords
        -- gss = updatedChords !! 0
    
    {- ============ HELPER FUNCTIONS ===================================== -}
    -- Compare target and guess strings and provide a 3-tuple response...
    -- ...of the correct pitch, note and octave respectively.
    feedback        :: [String] -> [String] -> (Int, Int, Int)
    feedback target guess = (pitch, note, octave)
        where   pitch = length (intersect target guess)

                note = 3 - pitch - length (deleteFirstsBy 
                    (\p1 -> \p2 -> (p1 !! 0) == (p2 !! 0)) guess target)

                octave = 3 - pitch - length (deleteFirstsBy 
                    (\p1 -> \p2 -> (p1 !! 1) == (p2 !! 1)) guess target)

    -- unpack GameState
    getState :: GameState -> [[String]]
    getState (GameState x) = x

    -- delete from list of chords all chords that don't match its score
    delChord' :: [[String]] -> [String] -> (Int, Int, Int) -> [[String]]
        -- for each chord in updatedChords as target, 
        -- ...find its score with pg as guess, ...
        -- remove where the score != actual score, then pick one.
    delChord' (x:xs) pg score
        | scoreComp (feedback x pg) score = x : delChord' xs pg score
        | otherwise = delChord' xs pg score
    
    -- compare if score is same
    scoreComp :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
    scoreComp (a, b, c) (x, y, z) = a==x && b==y && c==z
    
    -- pickOne :: [[String]] -> [String]
    -- for each `guess` in input (calculate the # of possible targets left)
        -- for each `target` in input except current
        --      calculate score1(guess, target)
        --      for each `other` in input
                --  matchcount[guess] = 0
                --  if score1 == score(other, target)
                    -- matchcount[guess] ++
    -- return guess with min(matchcount[guess])

    pickOne :: [[String]] -> [String]
    -- for each `guess` in input (calculate it's expected remaining candidates, minimize)
        -- for each `target` in input
        --      calculate score`(guess, target)
        --      flatten score (4a + 2b + a)
        --      add to list
    --      group, square and sum
    --      add result to a expList
    -- find idx of min value in expList
    -- return input[idx]
    pickOne input = input !! idx where
        idx = fromJust (elemIndex (minimum expList) expList) where
            expList = map (calcExpRemainCandidates input) input
    
    calcExpRemainCandidates :: [[String]] -> [String] -> Int
    calcExpRemainCandidates states guess = groupSquareSum scoreList where
        scoreList = map flattenScore tupleScoresList where
            tupleScoresList = map (feedback' guess) states

    flattenScore :: [Int] -> Int
    flattenScore [x, y, z] = 4*x + 2*y + z


    groupSquareSum :: [Int] -> Int
    groupSquareSum x = sum $ map (^2) $map length $ group $ sort x

    tupToList :: (Int, Int, Int) -> [Int]
    tupToList (x, y, z) = [x,y,z]

    feedback'        :: [String] -> [String] -> [Int]
    feedback' target guess = [pitch, note, octave]
        where   pitch = length (intersect target guess)

                note = 3 - pitch - length (deleteFirstsBy 
                    (\p1 -> \p2 -> (p1 !! 0) == (p2 !! 0)) guess target)

                octave = 3 - pitch - length (deleteFirstsBy 
                    (\p1 -> \p2 -> (p1 !! 1) == (p2 !! 1)) guess target)