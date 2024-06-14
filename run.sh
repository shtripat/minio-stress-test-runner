#!/bin/bash

ROOT_DIR="$PWD"

BASE_LOG_DIR="$ROOT_DIR/log"
LOG_FILE="test.log"
ERROR_FILE="error.log"
mkdir -p "$BASE_LOG_DIR"

function humanize_time() {
        time="$1"
        days=$((time / 60 / 60 / 24))
        hours=$((time / 60 / 60 % 24))
        minutes=$((time / 60 % 60))
        seconds=$((time % 60))

        ((days > 0)) && echo -n "$days days "
        ((hours > 0)) && echo -n "$hours hours "
        ((minutes > 0)) && echo -n "$minutes minutes "
        ((days > 0 || hours > 0 || minutes > 0)) && echo -n "and "
        echo "$seconds seconds"
}

# Start the test
start=$(date +%s)
./run-tests.sh 1>>"${BASE_LOG_DIR}/${LOG_FILE}" 2>"${BASE_LOG_DIR}/${ERROR_FILE}"
rv=$?
end=$(date +%s)
duration=$(humanize_time $((end - start)))
if [ "$rv" -eq 0 ]; then
        echo "done in $duration"
else
        echo "FAILED in $duration"
fi
