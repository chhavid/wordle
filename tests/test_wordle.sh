#! /bin/bash

function test_won_wordle() {
    local target_file=""
    local computer_word="FRAME"
    local database="database/comp_choices.txt"

    local expected_msg="Congratulations, You won."

    local actual_msg=$(play_wordle "${target_file}" "${computer_word}" "${database}" <<<"frame" 2>/dev/null)
    verify_expectation "" "${expected_msg}" "${actual_msg}" "Should show the winning msg, if the guess is correct." "play_wordle"
}

function test_play_wordle() {
    local target_file=""
    local computer_word="FRAME"
    local database="database/comp_choices.txt"
    local expected_status="1"
    local actual_status

    play_wordle "${target_file}" "${computer_word}" "${database}" <<<"flame" 2>/dev/null
    actual_status=$?
    verify_expectation "" "${expected_status}" "${actual_status}" "Should show nothing, if the guess is incorrect." "play_wordle"
}

function test_main() {
    echo -e "prove" >test_database.txt
    local database="test_database.txt"
    local target_file=""
    local expected_msg=$(echo -e "You failed. Game Over\nThe word was PROVE")

    local actual_msg=$(printf "aarti\naarti\naarti\naarti\naarti\naarti" | main "${database}" "${target_file}" 2>/dev/null)

    verify_expectation "" "${expected_msg}" "${actual_msg}" "Should show game over." "main"
    rm ${database}
}

function all_tests() {
    test_play_wordle
    test_main
    test_won_wordle
}

all_tests
