# bash-cache-warmer

This is a bash script that uses curl to warm up cache by targeting the sitemap.xml of the website

## Requirements

It uses the curl package and the website should have a sitemap.xml to work.

## Executing the script

You can pass as many URLs or IP as you want to the script like this:

    $ sudo chmod +x bash-cache-warmer.sh
    $ ./bash-cache-warmer.sh www.example1.com www.example2.com example3.com

## Room for improvement

If you happen to find something not to your liking, you are welcome to send a PR.
