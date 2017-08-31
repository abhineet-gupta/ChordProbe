#!/bin/bash

# ./Proj1Test D1 B1 G2 > ./results.txt

for note in {A..G}
do
    for octave in {1..3}
    do
        echo "$note$octave"
    done
done