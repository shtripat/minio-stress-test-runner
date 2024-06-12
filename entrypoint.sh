#!/bin/bash

./run.sh "$@" &

# Get the pid to be used for kill command if required
main_pid="$!"
trap 'echo -e "\nAborting enterprise stress test..."; kill $main_pid' SIGINT SIGTERM
# use -n here to catch run.sh exit code, notify to ci
wait -n
