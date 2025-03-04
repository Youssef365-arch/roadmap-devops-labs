#!/bin/bash

main() {
    # user input validation
    check_args $@
    
    tar_log_dir $@
}

tar_log_dir() {
    timestamp=$(date +%Y%m%d_%H%M%S)
    new_tar=logs_archive_$timestamp.tar.gz
    tar -czvf $new_tar $1

    logs_dir=logs_directory
    # move new_tar into log_dir (make log directory if doesn't already exist)
    mkdir -p $logs_dir && mv $new_tar ./$logs_dir
    echo [LOG] $new_tar successfully created in ./$logs_dir.
    # delete log directory after archiving it into a tar.gz (optional)
    # rm -r $1
}

check_args() {
    # user provided no cmd line args
    if [ -z "$1" ]; then
        echo -e "[ERROR] Must provide a log directory\n\tUsage: ./log-archive.sh <log-directory>"
        exit 1
    # user provided a non-directory
    elif [ ! -d "$1" ]; then
        echo -e "[ERROR] "$1" is not a directory\n\tUsage: ./log-archive.sh <log-directory>"
        exit 1
    fi
}

# pass cmd line args
main $@
