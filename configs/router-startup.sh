#!/bin/sh

# Install required packages
apk add --no-cache iptables iproute2 curl

# Configure network interfaces
ip addr add 10.1.0.1/24 dev eth0  # Management interface
ip addr add 10.1.1.1/24 dev eth1  # DMZ interface  
ip addr add 10.1.2.1/24 dev eth2  # Internal interface (database)
ip addr add 10.1.2.1/24 dev eth3  # Internal interface (admin)

# Bring interfaces up
ip link set eth0 up
ip link set eth1 up  
ip link set eth2 up
ip link set eth3 up

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Configure iptables rules
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow established connections
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow DMZ to internal (this is the misconfiguration!)
iptables -A FORWARD -s 10.1.1.0/24 -d 10.1.2.0/24 -j ACCEPT

# Allow internal to DMZ
iptables -A FORWARD -s 10.1.2.0/24 -d 10.1.1.0/24 -j ACCEPT

# Default deny
iptables -A FORWARD -j DROP

# Configure static routes for containers
ip route add 10.1.1.10/32 dev eth1
ip route add 10.1.2.20/32 dev eth2  
ip route add 10.1.2.30/32 dev eth3

echo "Router configuration complete"

# Keep container running
tail -f /dev/null

