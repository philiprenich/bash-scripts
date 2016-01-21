# Decode FileZilla's base64 encrypted passwords.
# Very basic, just takes a username. If you use the same username on different sites, I'm not sure what will happen.
# I should check for multiple matches and ask for the domain if that happens. Next version.

# Author: Philip Renich
# Version: 1.0
# Date: 21/01/2016

# Set this location to match your setup.
FILE="~/.config/filezilla/sitemanager.xml"

read -p "Username: " USER
PW=$(grep -A 1 "<User>$USER</User>" $FILE | sed -En 's/<Pass.*>(.+)<\/Pass>/\1/p')
if [ -z "$PW" ]; then
  echo "User not found."
else
  echo $PW | base64 --decode | pbcopy # Copy to clipboard on OS X
  echo -n "Password: "
  echo $PW | base64 --decode
  printf \\n
fi
