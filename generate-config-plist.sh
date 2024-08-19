#!/bin/bash

echo "Enter your Spotify API Client ID: "

read clientID

cat > "ApolloSpotify/ClientConfig.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ClientID</key>
	<string>$clientID</string>
</dict>
</plist>
EOF