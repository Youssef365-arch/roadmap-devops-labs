#!/bin/bash
: '

The goal of this project is to help you practice some basic shell scripting skills.
You will write a simple tool to analyze logs from the command line.

The log file contains the following fields:

IP address
Date and time
Request method and path
Response status code
Response size
Referrer
User agent

create a shell script that reads the log file and provides the following information:

Top 5 IP addresses with the most requests
    - look for the 5 highest requests, THEN extract the IP out of those lines.
Top 5 most requested paths
    - look for the 5 highest requested paths THEN extract the paths.
Top 5 response status codes
    -  look for the 5 highest response status codes THEN extract the codes
Top 5 user agents
    - look for the 5 highest user agents THEN extract the user agents

'

main() {
    # pass entire cmd line arg into validate_input()
    validate_input $@
    # Top 5 IP addresses with the most requests
    awk '{print $1}' $1 | sort | uniq -c | sort -r | head -n5 | awk '{printf "Top 5 IP addresses: %s (%d Requests)\n", $2, $1}'    
}

validate_input() {
    # user provided no cmd line args
    if [ -z "$1" ]; then
        echo -e "[ERROR] Must provide a log file\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    # user provided a directory
    elif [ -d "$1" ]; then
        echo -e "[ERROR] cannot remove '"$1"': Is a directory\n\tUsage: ./nginx-log-analyser </path/to/log-file>"
        exit 1
    fi
}

# pass entire cmd line arg into validate_input()
main $@
