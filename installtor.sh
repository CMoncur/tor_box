#!/bin/bash
#Install Tor for Raspberry Pi and configure IP tables
#Must be ran as ROOT 

/bin/echo "Updating system and installing Tor:"
/usr/bin/apt-get update
/usr/bin/apt-get upgrade
/usr/bin/apt-get install tor 

/bin/echo "Firewall settings:"
/sbin/iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 22 -j REDIRECT --to-ports 22
/sbin/iptables -t nat -A PREROUTING -i wlan0 -p udp --dport 53 -j REDIRECT --to-ports 53
/sbin/iptables -t nat -A PREROUTING -i wlan0 -p tcp --syn -j REDIRECT --to-ports 9040
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

/bin/sh -c "/sbin/iptables-save > /etc/iptables.ipv4.nat"

/bin/echo "Creating Log:"
/usr/bin/touch /var/log/tor/notices.log
/bin/chown debian-tor /var/log/tor/notices.log
/bin/chmod 644 /var/log/tor/notices.log

/bin/echo "Ensuring Tor starts when system boots up:"
/usr/sbin/update-rc.d tor enable

/bin/echo "Starting the Tor service:"
/usr/sbin/service tor start

/usr/bin/clear
/bin/echo "Done!"

exit
