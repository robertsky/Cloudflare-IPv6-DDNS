#!/usr/bin/env bash
# Script that will output needed information for cf-install.sh and cf-ddns-blank.sh

# Output formatting
info() { echo -e "\e[34m$@\e[0m"; }
warning() { echo -e "\e[33m$@\e[0m"; }
error() { echo -e "\e[31m$@\e[0m"; }

# Do not want to run as root user
test "$UID" -gt 0 || { error "This script cannot be run as root."; exit;}

# Check if dependencies are met before running
DEPS=(jq grep)
for i in $DEPS; do
  command -v $i >/dev/null 2>&1 || { error >&2 "Please install $i first"; exit 1; }
done

info "This script will help you configure a working Cloudflare DDNS script for a Linux machine.\n"
info "Please enter your Cloudflare API Key:"
read API_KEY

info "Please enter your Cloudflare user e-mail address:"
read EMAIL

info "Please enter the domain name associated with your Cloudflare account:"
read DOMAIN

info "Loading Cloudflare information"
curl https://www.cloudflare.com/api_json.html \
  -d a=rec_load_all \
  -d tkn=$API_KEY \
  -d email=$EMAIL \
  -d z=$DOMAIN \
 | jq '.'| grep -A 5 '"type": "A".'
