#!/bin/bash
# 
# USAGE : <script> 21  
#       Argument 1: number of pitches to test
#           e.g. 21; min=4; max=21; default=21
# REQUIREMENTS
#   - python
#   - Proj1Test in the same folder
# 
# DESC: Test all possible inputs for ChordProbe
#
# Declarative Programming, Project 1, S2 2017, UniMelb
# Abhineet Gupta - abhineetg@student.unimelb.edu.au
# -----------------------------------------------------

# create array of all possible pitches (21 of them)
PITCHES=($(for note in {A..G}; do for octave in {1..3}; do echo "$note$octave"; done; done))

# max number of pitches to create combinations from
# -1 due to zero-based indexing and last value in 'seq' being range inclusive
ARG=${1:-21}
MAX=$(($ARG-1))

for i in $(seq 0 $MAX)
do
    for j in $(seq $(($i+1)) $MAX)
    do
        for k in $(seq $(($j+1)) $MAX)
        do
            ./Proj1Test ${PITCHES[i]} ${PITCHES[j]} ${PITCHES[k]} >> temp_results.txt
        done
    done
done

# Put all results in one file that is overwritten
cat temp_results.txt > results.txt
# delete temp file so it can be create-appended to next time
rm temp_results.txt

# Get all guess scores
GUESSES=($(cat results.txt | grep 'You got it in \([0-9]\) guesses!' | grep -o '[0-9]'))
NUM_G=${#GUESSES[*]}
total=0

# Calculate their average
for num in ${GUESSES[*]}
do
    total=$((total + num))
done

# Use python as Bash only has integer division
AVG=$(echo print $total / $NUM_G.0 | python)

echo ""
echo "Avg #guesses/game : $AVG"
echo ""