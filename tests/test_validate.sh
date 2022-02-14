#! /bin/bash

function is_position_incorrect() {
    local user_guess="L"
    local computer_word="ELDER"
    local expected='incorrect-position'

    local actual=$(is_letter_included "${user_guess}" "${computer_word}")
    verify_expectation "" "${expected}" "${actual}" "Should show incorrect position" "is_letter_included"
}

function is_letter_wrong() {
    local user_guess="A"
    local computer_word="ELDER"
    local expected='wrong-letter'

    local actual=$(is_letter_included "${user_guess}" "${computer_word}")
    verify_expectation "" "${expected}" "${actual}" "Should show wrong letter" "is_letter_included"
}

function test_exact_match() {
    local user_guess="HELLO"
    local computer_word="HELLO"
    local expected="Congratulations, You won."

    local actual=$(check_exact_match "${user_guess}" "${computer_word}")
    verify_expectation "" "${expected}" "${actual}" "Should congratulate if match is exact" "check_exact_match"
}

function test_not_exact_match() {
    local user_guess="HOLLA"
    local computer_word="HELLO"
    local expected_status="1"
    local actual_status

    check_exact_match "${user_guess}" "${computer_word}"
    actual_status=$?
    verify_expectation "" "${expected_status}" "${actual_status}" "Should return 1 if match is not exact" "check_exact_match"
}

function test_is_five_letter() {
    local user_guess="word"
    local expected_msg="Enter 5 letter valid word"

    local actual_msg=$(validate_user_guess "${user_guess}")
    verify_expectation "" "${expected_msg}" "${actual_msg}" "Should show an error if user does not give five letter word" "validate_user_guess"
}

function test_invalid_word() {
    local user_guess="aaaaa"
    local database="database/comp_choices.txt"
    local expected_msg="Not in word list"

    local actual_msg=$(validate_user_guess "${user_guess}" "${database}")
    verify_expectation "" "${expected_msg}" "${actual_msg}" "Should show an error if user does not give invalid word" "validate_user_guess"
}

function test_validate_user_guess() {
    local user_guess="frame"
    local database="database/comp_choices.txt"
    local expected_status=0
    local actual_status

    validate_user_guess "${user_guess}" "${database}"
    actual_status=$?
    verify_expectation "" "${expected_status}" "${actual_status}" "Should return 0 if user gives valid word" "validate_user_guess"
}

function all_tests() {
    is_position_incorrect
    is_letter_wrong
    test_exact_match
    test_not_exact_match
    test_is_five_letter
    test_invalid_word
    test_validate_user_guess
}

all_tests
