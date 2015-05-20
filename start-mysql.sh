#!/bin/bash
echo "Beging config of mysql startup"

FILE=/Library/LaunchDaemons/com.mysql.mysql.plist
sudo touch $FILE
echo "${FILE} created"

sudo cat >$FILE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true />
    <key>Label</key>
    <string>com.mysql.mysqld</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/mysql/bin/mysqld_safe</string>
      <string>--user=mysql</string>
    </array>
  </dict>
</plist>
EOL

echo "Content dumped to file"

sudo chown root:wheel $FILE
sudo chmod 644 $FILE
echo "File permissions set to 644 and given to root"
sudo launchctl load -w $FILE
echo "File set to launch on system startup"