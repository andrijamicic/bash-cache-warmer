#!/bin/bash
#
# Written by AC - 2015 <contact@chemaly.com> - sys0dm1n.com
#
# The URLs or IPs variables are passed as an argument to the script like below:
# ./bash-cache-warmer.sh www.example1.com www.example2.com example3.com

VERSION='1.0.0'
USER_AGENT_MOBILE="Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
USER_AGENT_DESKTOP="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246"


warm_mobile() {
    echo "Warming cache for $1"
    curl -sL -A "$USER_AGENT_MOBILE" http://$1/sitemap.xml | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read line; do
        if [[ $line == *.xml ]]
        then
            newURL=$line
            curl -sL -A "$USER_AGENT_MOBILE" $newURL | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read newline; do
                time curl -sL -A "$USER_AGENT_MOBILE" -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
                echo $newline
            done
        else
            time curl -sL -A "$USER_AGENT_MOBILE" -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
            echo $line
        fi
    done
    echo "Done warming cache for $1"
}
warm_desktop() {
    echo "Warming cache for $1"
    curl -sL -A "$USER_AGENT_DESKTOP" http://$1/sitemap.xml | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read line; do
        if [[ $line == *.xml ]]
        then
            newURL=$line
            curl -sL -A "$USER_AGENT_DESKTOP" $newURL | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read newline; do
                time curl -sL -A "$USER_AGENT_DESKTOP" -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
                echo $newline
            done
        else
            time curl -sL -A "$USER_AGENT_DESKTOP" -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
            echo $line
        fi
    done
    echo "Done warming cache for $1"
}
for host in "$@"; do
    warm_mobile $host
    warm_desktop $host
done
