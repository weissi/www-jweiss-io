#!/bin/bash

CFG="/etc/ssh/sshd_config"

trap err ERR

function err() {
    echo >&2 "###############"
    echo >&2 "# FATAL ERROR #"
    echo >&2 "###############"
    exit 1
}

set -e


if [ $UID -ne 0 ]; then
    echo >&2 'ERROR: Please run as root'
    exit 1
fi

echo "============ FIXING SSH CONFIG ============"
echo "------------ Current config    ------------"
grep AllowUsers "$CFG"
echo "------------ Fixing config     ------------"
sed -ri 's/^AllowUsers.*$/AllowUsers weissi hendrik/g' "$CFG"
echo "------------ New config        ------------"
grep AllowUsers "$CFG"
echo "============ RESTART SSHD      ============"
service ssh restart
echo "============ SUCCESS           ============"
echo "Exiting successful"
exit 0
