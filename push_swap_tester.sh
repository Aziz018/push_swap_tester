#!/bin/bash

# Set text color to green
RED='\033[0;31m'
GREEN='\033[0;32m'

WHITE_BOLD='\033[1;37m'

GREEN_BOLD='\033[1;32m'
RED_BOLD='\033[1;31m'

BG_GREEN='\033[48;5;22m'
BG_RED='\033[48;5;124m'

# Reset text color
NC='\033[0m'


# Check if the number of arguments is not equal to 4
if [[ $# -ne 4 ]]; then
    echo "USAGE (need 4 ARGS): 
    ./test.sh [arg1: test count] [arg2: number of args]
    [arg1: min of range] [arg2: max of range]"
    exit 1
fi

# Extract the command-line arguments
test_count=$1
arg_count=$2
min_range=$3
max_range=$4

# Initialize the test result counter
successful_tests=0

# Loop for the specified number of tests
for ((i = 0; i < test_count; i++)); do
    # Generate a sequence of numbers with the provided range and shuffle, and take the specified number of elements
    args=$(seq $min_range $max_range | shuf -n $arg_count | tr '\n' ' ')

    # Run the push_swap program with the generated arguments and pipe the output to checker_linux with the same arguments
    output=$(./push_swap $args | ./checker_linux $args)

    # Check if the output contains the word "OK"
    if [[ $output == *"OK"* ]]; then
        # echo -e "Test $i ${GREEN_BOLD}OK${NC}"
        echo -e "${GREEN_BOLD}\n========> Test $i OK <========${NC}"
        successful_tests=$((successful_tests+1))
    else
        echo -e "${RED_BOLD}\n========> Test $i KO <========${NC}"
        # echo -e "${RED_BOLD}OK${NC}"
    fi
done

# Check if all tests were successful
if [[ $successful_tests -eq $test_count ]]; then
    echo -e "${GREEN}\n\t\t ██████╗ ██████╗ ███╗   ██╗ ██████╗ ██████╗  █████╗ ████████╗███████╗${NC}"
    echo -e "${GREEN}\t\t██╔════╝██╔═══██╗████╗  ██║██╔════╝ ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝${NC}"
    echo -e "${GREEN}\t\t██║     ██║   ██║██╔██╗ ██║██║  ███╗██████╔╝███████║   ██║   ███████╗${NC}"
    echo -e "${GREEN}\t\t██║     ██║   ██║██║╚██╗██║██║   ██║██╔══██╗██╔══██║   ██║   ╚════██║${NC}"
    echo -e "${GREEN}\t\t╚██████╗╚██████╔╝██║ ╚████║╚██████╔╝██║  ██║██║  ██║   ██║   ███████║${NC}"
    echo -e "${GREEN} \t\t╚═════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝${NC}\n"
    
else
    echo -e "${RED}\n\t\t ██▓     ▒█████   ▒█████    ██████ ▓█████  ██▀███  ${NC}"
    echo -e "${RED}\t\t▓██▒    ▒██▒  ██▒▒██▒  ██▒▒██    ▒ ▓█   ▀ ▓██ ▒ ██▒${NC}"
    echo -e "${RED}\t\t▒██░    ▒██░  ██▒▒██░  ██▒░ ▓██▄   ▒███   ▓██ ░▄█ ▒${NC}"
    echo -e "${RED}\t\t▒██░    ▒██   ██░▒██   ██░  ▒   ██▒▒▓█  ▄ ▒██▀▀█▄  ${NC}"
    echo -e "${RED}\t\t░██████▒░ ████▓▒░░ ████▓▒░▒██████▒▒░▒████▒░██▓ ▒██▒${NC}"
    echo -e "${RED}\t\t░ ▒░▓  ░░ ▒░▒░▒░ ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░░ ▒░ ░░ ▒▓ ░▒▓░${NC}"
    echo -e "${RED}\t\t░ ░ ▒  ░  ░ ▒ ▒░   ░ ▒ ▒░ ░ ░▒  ░ ░ ░ ░  ░  ░▒ ░ ▒░${NC}"
    echo -e "${RED}\t\t  ░ ░   ░ ░ ░ ▒  ░ ░ ░ ▒  ░  ░  ░     ░     ░░   ░ ${NC}"
    echo -e "${RED}\t\t    ░  ░    ░ ░      ░ ░        ░     ░  ░   ░    ${NC}\n"
fi