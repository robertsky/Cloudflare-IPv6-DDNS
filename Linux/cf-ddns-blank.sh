#!/usr/bin/env sh

CURR_IP_FILE=/var/tmp/current_ip.txt

# Try to write to the current IP address file, and exit if it cannot
( [ -e "\$CURR_IP_FILE" ] || touch "\$CURR_IP_FILE" ) && [ ! -w "\$CURR_IP_FILE" ] && error "Cannot write to $CURR_IP_FILE" && exit 1

#Variables that need to be set
API_KEY=
FULL_NAME=
DOMAIN=
REC_ID=
DISPLAY_NAME=

# Set NEWIP to the public IPv4 address of the network that your server is currently connected to
NEWIP=\$(dig +short myip.opendns.com @resolver1.opendns.com)

# Set CURRENTIP to whatever IPv4 address your domain name is currently pointed to
CURRENTIP=\$(dig $FULL_NAME +short)


# Compare IP addresses to see if anything has changed, and update CloudFlare if it has
if [ "\$NEWIP" = "\$CURRENTIP" ]; then
      echo "IP address unchanged"
  else
        echo "IP address has changed, updating CloudFlare..."

curl https://www.cloudflare.com/api_json.html \
    -d 'a=rec_edit'\
    -d 'tkn=$API_KEY'\
    -d 'email=$EMAIL'\
    -d 'z=$DOMAIN'\
    -d 'id=$REC_ID'\
    -d 'type=A'\
    -d 'name=$DISPLAY_NAME'\
    -d 'ttl=1'\
    -d "content=\$NEWIP"\
> /dev/null

                                                    # Update the tracked IP address
  echo \$NEWIP > \$CURR_IP_FILE
  fi
