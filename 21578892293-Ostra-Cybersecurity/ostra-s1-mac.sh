#!/bin/bash
REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main" 
LOCAL_DIR="/tmp/s1"
FILE_PATH="/tmp/s1/21578892293-Ostra-Cybersecurity/Sentinel-Release-24-4-1-7830_macos_v24_4_1_7830.pkg"
TOKEN_FILE="/tmp/s1/21578892293-Ostra-Cybersecurity/com.sentinelone.registration-token"

if [ -d "$LOCAL_DIR" ]; then
    echo "Removing existing directory: $LOCAL_DIR"
    rm -rf "$LOCAL_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to remove the existing directory."
        exit 1
    fi
fi

echo "Cloning the repository into $LOCAL_DIR..."
git clone --branch "$BRANCH" "$REPO_URL" "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

cd "$LOCAL_DIR" || { echo "Error: Failed to navigate to the local directory."; exit 1; }

echo "Applying registration token"
sudo chown root "$TOKEN_FILE"
#sudo echo "$TOKEN_FILE" | sudo tee "/Library/Managed Preferences/com.sentinelone.registration-token"
#sudo echo "$TOKEN_FILE" | sudo tee "/tmp/com.sentinelone.registration-token" > /dev/null

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist in the repository."
    exit 1
fi

echo "Installing the package..."
sudo installer -pkg "$FILE_PATH" -target /
if [ $? -ne 0 ]; then
    echo "Error: Failed to install the package."
    exit 1
fi

rm -rf $LOCAL_DIR
echo "File executed successfully!"