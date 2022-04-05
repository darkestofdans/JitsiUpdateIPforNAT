#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo "No domain provided.  ./updateip.sh sub.domain.tld"
    exit 1
fi
DOMAIN="$1"
SUB=$(echo "$1" | awk -F. '{print $1}')
NAME=$(echo "$1" | awk -F. '{print $2}')
TLD=$(echo "$1" | awk -F. '{print $3}')
if [[ $TLD == "" ]] ; then
    echo "No subdomain provided.  ./updateip.sh sub.domain.tld"
    exit 1
fi
currentIP=`curl 'ipinfo.io' | jq -r '.ip'` 
entry=`curl 'ipinfo.io' | jq -r '.ip' | awk '{print $0"\t" var" "SUB}' var=$DOMAIN SUB=$SUB`
if grep -E -q "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+[[:space:]]+$SUB\.$NAME\.$TLD[[:space:]]+$SUB" /etc/hosts; #check if the entry exists
then # if it does, update it and also create backup
        sed -i'.bak' "s/[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*[[:space:]]*$DOMAIN*[[:space:]]*$SUB/$currentIP $DOMAIN $SUB/g" /etc/hosts
else
        echo "$entry" >> /etc/hosts # add it if it doesnt exist
fi
head -n -1 /etc/jitsi/videobridge/sip-communicator.properties > /tmp/temp.txt
echo "org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS=$currentIP" >> /tmp/temp.txt
mv /tmp/temp.txt /etc/jitsi/videobridge/sip-communicator.properties