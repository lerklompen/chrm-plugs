#!/bin/bash

cat /home/chronos/user/Downloads/Google*Console.*tm* | col -b > console.mhtml

suff="</td"

API_KEY=$(grep -A 1 ">API key<" console.mhtml)
API_KEY=`echo $API_KEY | cut -d '>' -f 4`
API_KEY=`echo $API_KEY | tr -d ' ' | tr -d '='`
API_KEY="export GOOGLE_API_KEY=\"${API_KEY%$suff}\""

CLIENT_ID=$(grep -A 2 ">Client ID<" console.mhtml)
CLIENT_ID=`echo $CLIENT_ID | cut -d '>' -f 9`
CLIENT_ID=`echo $CLIENT_ID | tr -d ' ' | tr -d '='`
CLIENT_ID="export GOOGLE_DEFAULT_CLIENT_ID=\"${CLIENT_ID%$suff}\""

CLIENT_SECRET=$(grep -A 1 ">Client secret<" console.mhtml)
CLIENT_SECRET=`echo $CLIENT_SECRET | cut -d '>' -f 4`
CLIENT_SECRET=`echo $CLIENT_SECRET | tr -d ' ' | tr -d '='`
CLIENT_SECRET="export GOOGLE_DEFAULT_CLIENT_SECRET=\"${CLIENT_SECRET%$suff}\""

rm console.mhtml

echo "The following lines are now added to '/sbin/session_manager_setup.sh':
$API_KEY
$CLIENT_ID
$CLIENT_SECRET"

mount -o remount, rw /

sed -i -e "/Xauthority/a \\
$API_KEY \\
$CLIENT_ID \\
$CLIENT_SECRET
" /sbin/session_manager_setup.sh

mount -o remount, r /
