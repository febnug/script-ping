#!/bin/bash

# Cek apakah IP diberikan sebagai argumen
if [ -z "$1" ]; then
    echo "Usage: $0 <public-ip>"
    exit 1
fi

IP="$1"
LOGFILE="ip_status.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Cek status ping
ping -c 1 -W 2 "$IP" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    PING_STATUS="UP"
else
    PING_STATUS="DOWN"
fi

# Cek status HTTP (port 80)
curl --connect-timeout 3 -s "http://$IP" > /dev/null
if [ $? -eq 0 ]; then
    HTTP_STATUS="UP"
else
    HTTP_STATUS="DOWN"
fi

# Tampilkan hasil ke terminal
echo "[$DATE] IP: $IP | PING: $PING_STATUS | HTTP: $HTTP_STATUS"

# Simpan ke file log
echo "[$DATE] IP: $IP | PING: $PING_STATUS | HTTP: $HTTP_STATUS" >> "$LOGFILE"
