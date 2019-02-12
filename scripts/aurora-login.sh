#!/bin/bash

COOKIEJAR="/tmp/`whoami`-aurora-cookies2.txt"
AURORAHOST="portal.auroraenergy.com.au"
RDPFILE="/tmp/`whoami`-corp.rdp"

function PortalAction() {
        curl --compressed \
                --silent \
                -c $COOKIEJAR \
                -b $COOKIEJAR \
                -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
                -H 'Accept-Language: en-US,en;q=0.5' \
                -H 'Connection: keep-alive' \
                -H 'Content-Type: application/x-www-form-urlencoded' \
                -H "Host: $AURORAHOST" \
                -H 'Upgrade-Insecure-Requests: 1' \
                -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:59.0) Gecko/20100101 Firefox/59.0' "$@"
}

echo Attemping to use existing session
PortalAction "https://$AURORAHOST/rdpproxy/suprtsprd3.corp.local" > $RDPFILE

if ! grep 3389 $RDPFILE > /dev/null; then
        echo Session is defunct...
        PortalAction -H "Referer: https://$AURORAHOST/vpn/index.html" --data 'login=<user>&passwd=<pass>' "https://$AURORAHOST/cgi/login" > /dev/null
        printf "Enter 2f challenge: "
        read sfr
        PortalAction -H "Referer: https://$AURORAHOST/cgi/login" --data "response=$sfr" "https://$AURORAHOST/cgi/dlge" > /dev/null
        PortalAction -H "Referer: https://$AURORAHOST/cgi/login" "https://$AURORAHOST/cgi/setclient?cvpn" > /dev/null
        PortalAction "https://$AURORAHOST/rdpproxy/suprtsprd3.corp.local" > $RDPFILE
fi

if ! grep 3389 $RDPFILE > /dev/null; then
        echo Something went wrong when establishing the session... Excepted CORP.rdp Got:
        cat $RDPFILE
else
        echo Retreived $RDPFILE ... Starting RDP...
        # xfreerdp $RDPFILE /size:1910x1012
        nohup xfreerdp $RDPFILE /size:1920x1020 &>/dev/null &
fi
