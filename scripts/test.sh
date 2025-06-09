#!/bin/bash

# Corporate Data Breach CTF - Quick Test Script
# This script performs basic validation of the deployed environment

echo "🔍 Testing CTF Challenge Environment"
echo "==================================="

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Test web server accessibility
print_status "Testing web server accessibility..."
if curl -s http://localhost:8080 > /dev/null; then
    print_success "Web server is accessible"
else
    print_error "Web server is not accessible"
fi

# Test debug endpoint (vulnerability)
print_status "Testing debug endpoint..."
if curl -s http://localhost:8080/debug | grep -q "DB_HOST"; then
    print_success "Debug endpoint is exposing environment variables"
else
    print_error "Debug endpoint is not working as expected"
fi

# Test info endpoint
print_status "Testing info endpoint..."
if curl -s http://localhost:8080/info | grep -q "SecureCorp"; then
    print_success "Info endpoint is working"
else
    print_error "Info endpoint is not working"
fi

# Check if containers are running
print_status "Checking container status..."
if sudo containerlab inspect -t topology.yml > /dev/null 2>&1; then
    print_success "All containers are running"
else
    print_error "Some containers may not be running"
fi

echo ""
echo "Test completed. If all tests pass, the environment is ready for the CTF challenge."

