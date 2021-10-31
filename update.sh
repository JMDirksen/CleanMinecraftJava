#!/bin/bash
cd "$(dirname "$0")"

# Get current version
[ -f "server/version.txt" ] && current_version=$(cat "server/version.txt") || current_version=0
echo "Current version: $current_version"

# Get latest version
manifest_url="https://launchermeta.mojang.com/mc/game/version_manifest.json"
latest_version=$(curl -s "$manifest_url" | jq -r ".latest.release")
echo "Latest version: $latest_version"

# Exit if up-to-date
[ $current_version = $latest_version ] && { echo "Up-to-date"; exit; }

# Stopping server
echo "Stopping server..."
bash "stop.sh"

# Download new version
echo "Downloading new version..."
version_json_url=$(curl -s "$manifest_url" | jq -r ".versions[] | select(.id==\"$latest_version\") | .url")
server_url=$(curl -s "$version_json_url" | jq -r ".downloads.server.url")
wget -q "$server_url" -O "server/server.jar"
echo "$latest_version" > "server/version.txt"
echo "Updated!"

# Starting server
echo "Starting server..."
bash "start.sh"
echo "Done."
