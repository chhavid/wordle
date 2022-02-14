#! /bin/bash

source src/wordle_lib.sh

DATABASE="database/comp_choices.txt"

main "${DATABASE}" "wordle.html"
