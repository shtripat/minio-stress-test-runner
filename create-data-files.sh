#!/bin/bash -e

TEST_DATA_DIR="$TEST_ROOT_DIR/data"

declare -A data_file_map
data_file_map["datafile-0-b"]="0"
data_file_map["datafile-1-b"]="1"
data_file_map["datafile-1-kB"]="1K"
data_file_map["datafile-10-kB"]="10K"
data_file_map["datafile-33-kB"]="33K"
data_file_map["datafile-100-kB"]="100K"
data_file_map["datafile-1.03-MB"]="1056K"
data_file_map["datafile-1-MB"]="1M"
data_file_map["datafile-5-MB"]="5M"
data_file_map["datafile-5243880-b"]="5243880"
data_file_map["datafile-6-MB"]="6M"
data_file_map["datafile-10-MB"]="10M"
data_file_map["datafile-11-MB"]="11M"
data_file_map["datafile-65-MB"]="65M"
data_file_map["datafile-129-MB"]="129M"
data_file_map["datafile-500-MB"]="500M"
data_file_map["datafile-1-GB"]="1G"
data_file_map["datafile-5-GB"]="5G"

mkdir -p "$TEST_DATA_DIR"
for filename in "${!data_file_map[@]}"; do
	echo "creating $TEST_DATA_DIR/$filename"
	if ! shred -n 1 -s "${data_file_map[$filename]}" - 1>"$TEST_DATA_DIR/$filename" 2>/dev/null; then
		echo "unable to create data file $TEST_DATA_DIR/$filename"
		exit 1
	fi
done
