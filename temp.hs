    -- Early method to guess every possible chord
{-     nextGuessBrute :: ([String], GameState) -> (Int, Int, Int) -> 
        ([String], GameState)    
    nextGuessBrute (pg, GameState s) (cor, not, oct) = 
            (gss, newGameState) where
                newGameState = GameState updatedChords
                updatedChords = delChord s pg 
                    -- gamestate contains past guess
                gss = updatedChords !! 0
 -}
    
 {-     -- delete a chord from list of chords; used for brute force before
    delChord :: [[String]] -> [String] -> [[String]]
    delChord (x:xs) y
        | null (x \\ y) = xs
        | otherwise = x : delChord xs y
 -}
