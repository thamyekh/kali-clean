#!/usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script needs to be run with sudo."
    exit 1
fi

DEBIAN_FRONTEND=noninteractive apt -yq install dnsmasq
echo 'no-dhcp-interface=' > /etc/dnsmasq.conf
echo "server=$(awk '/nameserver/{print $2}' '/etc/resolv.conf')" >> /etc/dnsmasq.conf
systemctl enable dnsmasq && systemctl restart dnsmasq
