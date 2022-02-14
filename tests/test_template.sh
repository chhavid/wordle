#! /bin/bash

function correct_position() {
    source src/wordle_lib.sh

    local user_guess="ELDER"
    local computer_word="ELDER"
    local expected_template='<html> <head> <title>Wordle</title> <link rel="stylesheet" href="src/styles.css" /> <link rel="shortcut icon" href="images/wordle_logo_32x32.png" type="image/x-icon"> </head> <body> <div class="page-wrapper"> <h1>WORDLE</h1> <table class="results"> <tbody> <tr> <td class="correct-position">E</td> <td class="correct-position">L</td> <td class="correct-position">D</td> <td class="correct-position">E</td> <td class="correct-position">R</td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> </tbody> </table> </div> </body> </html>'

    modify_template "${user_guess}" "${computer_word}"
    verify_expectation "" "${expected_template}" "${TEMPLATE}" "Should check for correct position" "modify_template"
}

function incorrect_position() {
    source src/wordle_lib.sh

    local user_guess="LERDE"
    local computer_word="ELDER"
    local expected_template='<html> <head> <title>Wordle</title> <link rel="stylesheet" href="src/styles.css" /> <link rel="shortcut icon" href="images/wordle_logo_32x32.png" type="image/x-icon"> </head> <body> <div class="page-wrapper"> <h1>WORDLE</h1> <table class="results"> <tbody> <tr> <td class="incorrect-position">L</td> <td class="incorrect-position">E</td> <td class="incorrect-position">R</td> <td class="incorrect-position">D</td> <td class="incorrect-position">E</td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> </tbody> </table> </div> </body> </html>'

    modify_template "${user_guess}" "${computer_word}"
    verify_expectation "" "${expected_template}" "${TEMPLATE}" "Should check for incorrect position" "modify_template"
}

function test_apply_template() {
    source src/wordle_lib.sh
    local letter="a"
    local result="pass"
    local expected='<html> <head> <title>Wordle</title> <link rel="stylesheet" href="src/styles.css" /> <link rel="shortcut icon" href="images/wordle_logo_32x32.png" type="image/x-icon"> </head> <body> <div class="page-wrapper"> <h1>WORDLE</h1> <table class="results"> <tbody> <tr> <td class="pass">a</td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> <tr> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> <td class="_RESULT_"></td> </tr> </tbody> </table> </div> </body> </html>'

    local actual=$(apply_template "${letter}" "${result}")
    verify_expectation "" "${expected}" "${actual}" "Should write letter and result to the template" "apply_template"
}

function all_tests() {
    correct_position
    incorrect_position
    test_apply_template
}

all_tests
