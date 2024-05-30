#!/bin/bash

mv re8723bs.sh /usr/local/bin
mv re8723bs.service /etc/systemd/system/

systemctl enable re8723bs.service
systemctl start re8723bs.service
