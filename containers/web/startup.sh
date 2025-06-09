#!/bin/sh

# Install PHP-FPM for dynamic content
apk add --no-cache php81 php81-fpm php81-mysqli

# Configure network interface
ip addr add 10.1.1.10/24 dev eth0
ip link set eth0 up

# Add route to internal network via router
ip route add 10.1.2.0/24 via 10.1.1.1

# Start PHP-FPM
php-fpm81 -D

# Start nginx
nginx -g "daemon off;"

