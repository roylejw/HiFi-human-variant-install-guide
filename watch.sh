#!/bin/bash

# Set your local folder path and S3 bucket name
LOCAL_FOLDER="/home/ubuntu/cromwell-executions"
S3_BUCKET="s3://variant-out/"

export LOCAL_FOLDER
export S3_BUCKET

# Function to sync local folder to S3 bucket
sync_to_s3() {
        aws s3 sync "$LOCAL_FOLDER" "$S3_BUCKET"
}

export -f sync_to_s3

# Watch for changes in the local folder and sync to S3 when changes occur
watch -n 600 -x bash -c "sync_to_s3"
