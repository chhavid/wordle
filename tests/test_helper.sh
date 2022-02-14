#! /bin/bash

function test_select_computer_word() {
    local database="test.txt"
    echo "hello" >${database}
    local expected_word="hello"

    local actual_word=$(select_computer_word ${database})
    rm ${database}
    verify_expectation "" "${expected_word}" "${actual_word}" "Should select a random computer word from database" "select_computer_word"
}

function test_capitalize_word() {
    local word="word"
    local expected="WORD"

    local actual=$(capitalize_word "${word}")
    verify_expectation "" "${expected}" "${actual}" "Should capitalize the given word" "capitalize_word"
}

function test_read_word() {
    local expected_word="hello"

    local actual_word=$(read_word <<<"hello")
    verify_expectation "" "${expected_word}" "${actual_word}" "Should read the word given by user" "read_word"
}

function test_write_file() {
    local target_file="test.html"
    local expected=$(cat src/template.html)

    write_file "${target_file}"
    local actual=$(cat ${target_file})

    verify_expectation "" "${expected}" "${actual}" "Should write to the target file" "write_file"
    rm "${target_file}"
}

function all_tests() {
    test_select_computer_word
    test_capitalize_word
    test_read_word
    test_write_file
}

all_tests
