### Sentinelone
echo "Installing SentinelOne"
url="https://github.com/ocs-eb1/ocs-epdr/releases/download/v1.0.0/Sentinel-Release-25-3-4-8365_macos_v25_3_4_8365.pkg"
LOCAL_DIR="/tmp/s1"
mkdir -p "$LOCAL_DIR"
TOKEN=“actual token”
TOKEN_FILE="/tmp/s1/com.sentinelone.registration-token"
FILE_PATH="$LOCAL_DIR/Sentinel-Release-25-3-4-8365_macos_v25_3_4_8365.pkg"

curl -o "$FILE_PATH" -L "$url"
if [ $? -ne 0 ]; then
echo "Error. downloading file"
exit 1
fi

cd "$LOCAL_DIR" || { echo "Error: Failed to navigate to the local directory."; exit 1; }

echo "Applying registration token"
sudo touch "$TOKEN_FILE"
sudo chmod 777 "$TOKEN_FILE"
sudo echo "$TOKEN" > "$TOKEN_FILE"
if [ -f "$TOKEN_FILE" ]; then
echo "File Created"
else
echo "Failed to create file"
fi
sudo chown root "$TOKEN_FILE"

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

sudo rm -rf "$LOCAL_DIR"
echo "File executed successfully!"
