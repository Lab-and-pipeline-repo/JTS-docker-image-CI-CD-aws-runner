#!/bin/bash

# Create a folder
echo -e "Step 1: Creating folder...\n"
mkdir actions-runner && cd actions-runner
echo -e "Step 1: Folder created.\n-----------------------------------------------------------------"

# Download the latest runner package
echo -e "Step 2: Downloading the latest runner package...\n"
curl -o actions-runner-linux-x64-2.315.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.315.0/actions-runner-linux-x64-2.315.0.tar.gz
echo -e "Step 2: Download completed.\n-----------------------------------------------------------------"

# Optional: Validate the hash
echo -e "Step 3: Validating hash...\n"
echo  "6362646b67613c6981db76f4d25e68e463a9af2cc8d16e31bfeabe39153606a0  actions-runner-linux-x64-2.315.0.tar.gz" | shasum -a 256 -c
echo -e "Step 3: Hash validated.\n-----------------------------------------------------------------"

# Extract the installer
echo -e "Step 4: Extracting the installer...\n"
tar xzf ./actions-runner-linux-x64-2.315.0.tar.gz
echo -e "Step 4: Installer extracted.\n-----------------------------------------------------------------"

echo -e "=================TASK completed Sucessfully======================"

