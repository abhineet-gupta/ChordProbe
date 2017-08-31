#!/bin/bash

# create array of all possible pitches (21 of them)
PITCHES=($(for note in {A..G}; do for octave in {1..3}; do echo "$note$octave"; done; done))

# max number of pitches to create combinations from
# MIN: 3
# MAX: 21
# -1 due to zero-based indexing and last value in 'seq' being range inclusive
MAX=$(($1-1))

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
echo "Average guesses: $AVG"
echo ""