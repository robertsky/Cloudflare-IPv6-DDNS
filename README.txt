# Cloudflare-DDNS Script and Installer Readme

Description: 
Cloudflare dynamic dns script will update your Cloudflare hosted domain's public IPv4 address to the address that your server is connected to. Compatible with IPv6 enabled modems.

Compatible with any Linux OS with necessary dependencies installed, as well as Bash on Ubuntu on Windows.


Five pieces of information will be needed to added to cf-ddns.sh for the script to work. Edit cf-ddns.sh so that the variables at the beginning of the script equal the following information:

1. The zone record that you will be updating (zone.example.com for a subdomain, or just example.com)
2. The email associated with your cloudflare login
3. Your cloudflare API key (found in My Settings > API Key)
4. The rec_id of the zone record
5. The main domain name that your zone record is associated with (example.com)



If you do not know how to obtain this information refer to installation instructions below:




TO INSTALL:


1. Wizard: Execute cf-install.sh and it will walk you through setting up the script. 

Main required programs for cf-install.sh to work: 
jq (https://stedolan.github.io/jq/)
grep
curl



OR:

2. Manually: Edit the text of cf-ddns-blank.sh and set the variables at the beginning with the information from the output of the cf-info.sh script.

**For Windows 10 users running BASH on Ubuntu on Windows follow the same instructions but just use the scripts that are located in the Bash-On-Ubuntu-On-Windows directory.**





Once the cf-ddns.sh script is configured properly, execute it and it will update the A record of the associated zone to the IP address of the network the computer the script is being run from.

Once confirmed it is working, the script can be set as a cron job or be used by an automation program such as Jenkins to run frequently to avoid any downtime if your ISP changes your public IP address.
