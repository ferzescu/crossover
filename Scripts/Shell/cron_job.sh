#!/bin/bash

# Collects log files from Dockers
/root/copy_docker_files.sh
/root/make_backup.sh

# Send file to S3
/usr/bin/env python /root/log_file_upload.py AKIAJDKV73TAC4S75MNA KuQo71NdyV27xcUt6wPX8gHKYUGwFcz6q3vNXtxM
/usr/bin/env python /root/bkp_file_upload.py AKIAJDKV73TAC4S75MNA KuQo71NdyV27xcUt6wPX8gHKYUGwFcz6q3vNXtxM
