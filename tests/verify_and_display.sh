#! /bin/bash

LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
NORMAL="\033[0m"
BOLD="\033[1m"

PASSED_TESTS=0
FAILED_TESTS=0
TOTAL_TESTS=0
FAILED_TESTS_CONTENT=()
LAST_FUNCTION_NAME=""

# general subroutines
function verify_expectation() {
	local inputs=$1
	local expected=$2
	local actual=$3
	local test_case=$4
	local function_name=$5

	local test_outcome="${LIGHT_RED}   ✘${NORMAL}"
	if [[ "${expected}" == "${actual}" ]]; then
		test_outcome="${LIGHT_GREEN}   ✔${NORMAL}"
		PASSED_TESTS=$((${PASSED_TESTS} + 1))
	else
		local pos=${#FAILED_TESTS_CONTENT[@]}
		FAILED_TESTS_CONTENT[${pos}]="${function_name};${test_case};${inputs};${expected};${actual}"
		FAILED_TESTS=$((${FAILED_TESTS} + 1))
	fi

	print_function_name $function_name
	echo -e "${test_outcome} ${test_case}"
}

function display_failed_tests() {
	local failed_test=""
	local test_number=1
	local pre_function_name=""

	echo -e "\n${LIGHT_RED} Failed Tests->${NORMAL}"

	for failed_test in "${FAILED_TESTS_CONTENT[@]}"; do
		function_name=$(echo ${failed_test} | cut -d";" -f1)
		print_function_name $function_name

		echo -e "\n${NORMAL}     ${test_number}. Test case : "$(echo ${failed_test} | cut -d";" -f2)
		echo -e "\tInputs    : "$(echo ${failed_test} | cut -d";" -f3)
		echo -e "\tExpected  : "$(echo ${failed_test} | cut -d";" -f4)
		echo -e "\tActual    : "$(echo ${failed_test} | cut -d";" -f5)

		test_number=$((${test_number} + 1))
	done
}

function display_result() {
	[[ ${FAILED_TESTS} > 0 ]] && display_failed_tests

	TOTAL_TESTS=$((${PASSED_TESTS} + ${FAILED_TESTS}))
	echo -e "\n\t${BOLD}Total ${TOTAL_TESTS}${NORMAL}    ${LIGHT_GREEN}${PASSED_TESTS} Passing    ${LIGHT_RED}${FAILED_TESTS} Failing${NORMAL}\n"
}

function print_function_name {
	function_name=$1

	if [[ "${function_name}" != "${LAST_FUNCTION_NAME}" ]]; then
		LAST_FUNCTION_NAME="${function_name}"
		echo -e "\n${BOLD} $function_name"
	fi
}