#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'

WHITE_BOLD='\033[1;37m'

GREEN_BOLD='\033[1;32m'
RED_BOLD='\033[1;31m'

BG_GREEN='\033[48;5;22m'
BG_RED='\033[48;5;124m'

NC='\033[0m'


if [[ $# -ne 4 ]]; then
    echo "USAGE (need 4 ARGS): 
    ./test.sh [arg1: test count] [arg2: number of args]
    [arg1: min of range] [arg2: max of range]"
    exit 1
fi

test_count=$1
arg_count=$2
min_range=$3
max_range=$4

successful_tests=0

for ((i = 0; i < test_count; i++)); do
    args=$(seq $min_range $max_range | shuf -n $arg_count | tr '\n' ' ')

    output=$(./push_swap $args | ./checker_linux $args)
    moves=$(./push_swap $args | wc -l)
    if [[ $output == *"OK"* && $arg_count -eq 100 && $moves -lt 700 ]]; then
        echo -e "\n${GREEN_BOLD}========> Test $i OK <========${NC}"
        echo -e "\n${BG_GREEN}${WHITE_BOLD} $moves moves ${NC}"
        successful_tests=$((successful_tests+1))
    elif [[ $output == *"OK"* && $arg_count -eq 500 && $moves -lt 5500 ]]; then
        echo -e "\n${GREEN_BOLD}========> Test $i OK <========${NC}"
        echo -e "\n${BG_GREEN}${WHITE_BOLD} $moves moves ${NC}"
        successful_tests=$((successful_tests+1))
    elif [[ $output == *"OK"* && $arg_count -gt 500 ]]; then
        echo -e "\n${GREEN_BOLD}========> Test $i OK <========${NC}"
        echo -e "\n${BG_GREEN}${WHITE_BOLD} $moves moves ${NC}"
        successful_tests=$((successful_tests+1))
    else
        echo -e "\n${RED_BOLD}========> Test $i KO <========${NC}"
        echo -e "\n${BG_RED}${WHITE_BOLD}$moves moves ${NC}"
    fi
done

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
