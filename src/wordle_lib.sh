#! /bin/bash
TEMPLATE=$(cat src/template.html)

function capitalize_word() {
    local word="$1"

    tr "[:lower:]" "[:upper:]" <<<"${word}"
}

function validate_user_guess() {
    local user_guess="$1"
    local database="$2"

    grep -q "^.....$" <<<${user_guess} 2>/dev/null
    [[ $? != 0 ]] && echo "Enter 5 letter valid word" && return 1

    grep -q "$user_guess"  ${database} 2>/dev/null
    status1="$?"

    grep -q "$user_guess" database/other_valid_words.txt 2>/dev/null
    status2="$?"

    [[ $status1 != 0 ]] && [[ $status2 != 0 ]] && echo "Not in word list" && return 1
    return 0
}

function read_word() {
    local word
    read -p "Enter a five letter word: " word

    echo "${word}"
}

function write_file() {
    local target_file="$1"

    echo -n "${TEMPLATE}" >${target_file}
}

function apply_template() {
    local letter="$1"
    local result="$2"

    sed "s#></td>#>${letter}</td># ;
         s#_RESULT_#${result}#" <<<${TEMPLATE}
}

function check_exact_match() {
    local user_guess="$1"
    local computer_word="$2"

    if [[ "${user_guess}" == "${computer_word}" ]]; then
        echo "Congratulations, You won."
    else
        return 1
    fi
}

function is_letter_included() {
    local letter="$1"
    local word="$2"
    local result="wrong-letter"

    if (grep -q $letter <<<$word); then
        result="incorrect-position"
    fi

    echo "$result"
}

function modify_template() {
    local user_guess="$1"
    local computer_word="$2"
    local result index

    for index in $(seq 0 4); do
        if [[ ${user_guess:$index:1} == ${computer_word:$index:1} ]]; then
            result="correct-position"
        else
            result=$(is_letter_included "${user_guess:$index:1}" "${computer_word}")
        fi
        TEMPLATE=$(apply_template "${user_guess:${index}:1}" "${result}")
    done
}

function play_wordle() {
    local target_file="$1"
    local computer_word="$2"
    local database="$3"
    local status=1

    while [[ ${status} == 1 ]]; do
        local user_input=$(read_word)
        validate_user_guess "${user_input}" ${database}
        status=$?
    done

    local user_guess=$(capitalize_word "$user_input")

    modify_template "${user_guess}" "${computer_word}"
    write_file "${target_file}"
    open ${target_file} 2>/dev/null
    check_exact_match "${user_guess}" "${computer_word}"
    if [[ $? == 1 ]];then
        return 1
    fi
}

function select_computer_word() {
    local database="$1"
    local count=$(wc -l "$database" | cut -f1 -d"${database:0:1}")
    local random_number=$(jot -r 1 1 $count)
    head -n ${random_number} $database | tail -n 1
}

function main() {
    local database="$1"
    local target_file="$2"
    local computer_word=$(select_computer_word $database)
    computer_word=$(capitalize_word $computer_word)
    for chance in $(seq 6); do
        play_wordle "$target_file" "${computer_word}" ${database}
        if [[ $? != 1 ]]; then
            return
        fi    
    done
    echo "You failed. Game Over"
    echo "The word was $computer_word"
}