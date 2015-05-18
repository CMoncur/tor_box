#!/bin/bash
#Install Tor for Raspberry Pi and configure IP tables
#Must be ran as ROOT 

/bin/echo "Updating system and installing Tor:"
/usr/bin/apt-get -y update
/usr/bin/apt-get -y upgrade
/usr/bin/apt-get -y install tor 

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

/bin/echo "Configuring Tor for Wifi access point:"
/bin/cat >/etc/tor/torrc <<tor_config 
## Wifi Access Point Configuration
## Assumes you've configured your access point similar to LadyAda's "Pi as Access Point" tutorial

# Log File
Log notice file /var/log/tor/notices.log

VirtualAddrNetwork 10.192.0.0/10
AutomapHostsSuffixes .onion,.exit
AutomapHostsOnResolve 1

# Transparent Port
TransPort 9040
TransListenAddress 192.168.42.1

# DNS Port
DNSPort 53
DNSListenAddress 192.168.42.1

## Tor Relay Configuration

# SOCKS Port
SocksPort 0

# Run Tor as Daemon (0 for no, 1 for yes)
RunAsDaemon 1
tor_config

/bin/echo "Ensuring Tor starts when system boots up:"
/usr/sbin/update-rc.d tor enable

/bin/echo "Starting the Tor service:"
/usr/sbin/service tor start

/usr/bin/clear
/bin/echo "Done!"

exit
