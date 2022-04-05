# Bash Script to Update Dynamic IP for NAT for Jitsi Meet
If you're using Jitsi Meet, have a Dynamic IP, and are using Jitsi behind NAT there are two lines that will need to be updated whenever your IP address changes.  This script will update /etc/hosts and /etc/jitsi/videobridge/sip-communicator.properties.
## Installation
```
git clone https://github.com/darkestofdans/JitsiUpdateIPforNAT.git
cd JitsiUpdateIPforNAT
sudo chown root:root changeip.sh
sudo chmod 700 changeip.sh
```
Set a cronjob based on your needs to run the script.  Here's an example for every 8 hours and at reboot:
```
sudo crontab -e
```
Add:
```
@reboot sleep 100 && /path/to/file/updateip.sh subdomain.example.com
0 */8 * * * /path/to/file/updateip.sh subdomain.example.com
```
## Usage
Run the script with your domain name.  It is important to note this script only works when using a subdomain such as subdomain.example.com.
```
sudo ./changeip.sh subdomain.example.com
```
## Thank yous
Thank you https://github.com/edrapac and https://github.com/smooklu for you help