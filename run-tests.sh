#!/bin/bash

function main() {
	# Create alias to the server
	mc alias set myminio "{MINIO_ENDPOINT}" "${MINIO_ACCESS_KEY}" "${MINIO_SECRET_KEY}"

	COUNT=0
	while true; do
		# If its 2 days (48 hrs * 60 min) and sleep of 10m each for every loop
		if [ ${COUNT} -eq 288 ]; then
			break
		fi
		# Create bucket
		mc mb myminio/bucket1

		mc version enable myminio/bucket1

		# Load few versions of the objects to the bucket
		for i in {1..5}; do
			mc cp "${TEST_DATA_DIR}/datafile-0-b" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-0-b" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-1-b" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-1-kB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-10-kB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-33-kB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-100-kB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-1.03-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-1-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-5-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-5243880-b" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-6-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-10-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-11-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-65-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-129-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-500-MB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-1-GB" myminio/bucket1
			mc cp "${TEST_DATA_DIR}/datafile-5-GB" myminio/bucket1
		done

		# List the bucket content
		mc ls myminio/bucket1

		# List all the versions
		mc ls myminio/bucket1 --versions

		# Delete the objects
		mc rm myminio/bucket1/datafile-0-b
		mc rm myminio/bucket1/datafile-0-b
		mc rm myminio/bucket1/datafile-1-b
		mc rm myminio/bucket1/datafile-1-kB
		mc rm myminio/bucket1/datafile-10-kB
		mc rm myminio/bucket1/datafile-33-kB
		mc rm myminio/bucket1/datafile-100-kB
		mc rm myminio/bucket1/datafile-1.03-MB
		mc rm myminio/bucket1/datafile-1-MB
		mc rm myminio/bucket1/datafile-5-MB
		mc rm myminio/bucket1/datafile-5243880-b
		mc rm myminio/bucket1/datafile-6-MB
		mc rm myminio/bucket1/datafile-10-MB
		mc rm myminio/bucket1/datafile-11-MB
		mc rm myminio/bucket1/datafile-65-MB
		mc rm myminio/bucket1/datafile-129-MB
		mc rm myminio/bucket1/datafile-500-MB
		mc rm myminio/bucket1/datafile-1-GB
		mc rm myminio/bucket1/datafile-5-GB
		
		# List the versions again
		mc ls myminio/bucket1 --versions

		# Remove the bucket
		mc rb myminio/bucket1 --force --dangerous

		# Try to load a million objects to new bucket
		mc mb myminio/bucket2
		for i in {1..1000000}; do
			echo "Hello World" | mc pipe myminio/bucket2/obj$i
		done

		# Try to stat the objects
		for i in {1..1000000}; do
			mc stat myminio/bucket2/obj$i
		done

		# Try to download the objects
		mkdir ${ROOT_DIR}/tmp
		for i in {1..1000000}; do
			mc get myminio/bucket2/obj$i ${ROOT_DIR}/tmp/obj$i
		done
		rm -rf ${ROOT_DIR}/tmp

		sleep 10m
		COUNT=$((COUNT + 1))
	done
}
main "$@"
