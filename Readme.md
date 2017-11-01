# ChordProbe

## COMP90048 Declarative Programming

University of Melbourne

Project 1 - Sem 2, 2017

### Project specification can be found [here](proj1.pdf)

---

Source file is [Proj1.hs](Proj1.hs)

## Usage

```haskell
ghc -O2 --make Proj1Test
```

Run by supplying chord e.g.

```bash
./Proj1Test A1 B2 C3
```

---

### Brief Description

In the game of ChordProbe, this program performs the role of the 'performer' and guesses the correct 3-pitch chord while receiving feedback from the composer.

---

## Performance Testing

Performance of program can be tested by calculating the average number of guesses it takes to correctly guess the chord.

This has been autoamted using the [averageGuesses.sh](averageGuesses.sh) script.

```bash
./averageGuesses.sh 21
```

_Argument 1_: number of pitches to test e.g. 21; min=4; max=21; default=21

---