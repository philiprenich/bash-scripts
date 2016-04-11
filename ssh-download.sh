#!/bin/bash

# SSH into a remote server, send a gzipped tarball to the current working directory on local.

# Author: Philip Renich
# Version: 1.0
# Date: 11/04/2016

read -p "Username: " USER
read -p "Host: " HOST
read -p "Remote dir: " REMOTE_DIR
read -p "Filename: " FILE

ssh $USER@$HOST tar czfv - ./$REMOTE_DIR > ./$FILE
