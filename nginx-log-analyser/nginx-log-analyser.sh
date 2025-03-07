#!/bin/bash

main() {
    # pass entire cmd line arg into validate_input()
    validate_input $@

    # Top 5 IP addresses with the most requests
    echo Top 5 IP addresses: 
    awk '{print $1}' $1 | sort | uniq -c | sort -r | head -n5 | awk '{printf "%s (%d Requests)\n", $2, $1}'
    
    echo
    
    # Top 5 most requested paths
    echo Top 5 most requested paths: 
    awk '{print $7}' $1 | sort | uniq -c | sort -r | head -n5 | awk '{printf "%s (%d Requests)\n", $2, $1}'

    echo

    # Top 5 response status codes (print response status codes between 100-599)
    echo Top 5 response status codes: 
    grep -oE ' [1-5][0-9]{2} ' $1 | sort | uniq -c | sort -r | head -n5 | awk '{printf "%s (%d Requests)\n", $2, $1}'

    echo

    # Top 5 user agents
    echo Top 5 user agents
    awk -F'"' '{print $6}' $1 | sort | uniq -c | sort -r | head -n5 | awk '{printf "%s (%d Requests)\n", substr($0, index($0, $2)), $1}'
}

validate_input() {
    # user provided no cmd line args
    if [ -z "$1" ]; then
        echo -e "[ERROR] Must provide a log file\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    # user provided more than 1 cmd line arg
    elif [ $# -ne 1 ]; then
        echo -e "[ERROR] Must provide only one argument\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    # argument/file provided by user cannot be found
    elif [ ! -f "$1" ]; then
        echo -e "[ERROR] '"$1"' not found\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    # user provided a directory
    elif [ -d "$1" ]; then
        echo -e "[ERROR] cannot remove '"$1"': Is a directory\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    fi
}

# pass entire cmd line arg into validate_input()
main $@
