#!/bin/bash

LOG_FILE="/var/log/syslog"
SEARCH_STRING="rtl8723bs mmc1:0001:1 wlan0: sd_recv_rxfifo: alloc recvbuf FAIL!"

tail -n 0 -F "$LOG_FILE" | grep --line-buffered "$SEARCH_STRING" | while read -r line
do
    sudo rmmod r8723bs && sudo modprobe r8723bs
    sudo iwlist wlan0 scanning
done