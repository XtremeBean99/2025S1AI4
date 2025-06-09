#!/bin/bash

# Corporate Data Breach CTF - Deployment Script
# This script sets up the Containerlab environment and deploys the CTF challenge

set -e  # Exit on any error

echo "🚀 Starting Corporate Data Breach CTF Deployment"
echo "================================================"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root for security reasons"
   exit 1
fi

# Check if containerlab is installed
print_status "Checking for Containerlab installation..."
if ! command -v containerlab &> /dev/null; then
    print_warning "Containerlab not found. Installing..."
    
    # Install containerlab
    bash -c "$(curl -sL https://get.containerlab.dev)" || {
        print_error "Failed to install Containerlab"
        exit 1
    }
    
    print_success "Containerlab installed successfully"
else
    print_success "Containerlab is already installed"
fi

# Check if Docker is installed and running
print_status "Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

if ! docker info &> /dev/null; then
    print_error "Docker is not running. Please start Docker service."
    exit 1
fi

print_success "Docker is installed and running"

# Check if we're in the correct directory
if [[ ! -f "topology.yml" ]]; then
    print_error "topology.yml not found. Please run this script from the CTF challenge directory."
    exit 1
fi

# Pull required Docker images
print_status "Pulling required Docker images..."
docker pull alpine:latest || print_warning "Failed to pull alpine:latest"
docker pull nginx:alpine || print_warning "Failed to pull nginx:alpine"
docker pull mysql:8.0 || print_warning "Failed to pull mysql:8.0"

print_success "Docker images pulled successfully"

# Make scripts executable
print_status "Setting script permissions..."
chmod +x configs/router-startup.sh
chmod +x containers/web/startup.sh
chmod +x scripts/teardown.sh

# Deploy the lab
print_status "Deploying Containerlab topology..."
sudo containerlab deploy -t topology.yml || {
    print_error "Failed to deploy Containerlab topology"
    exit 1
}

print_success "Containerlab topology deployed successfully"

# Wait for services to start
print_status "Waiting for services to initialize..."
sleep 30

# Test connectivity
print_status "Testing service connectivity..."

# Test web server
if curl -s http://localhost:8080 > /dev/null; then
    print_success "Web server is accessible at http://localhost:8080"
else
    print_warning "Web server may not be ready yet. Try accessing http://localhost:8080 in a few minutes."
fi

# Display challenge information
echo ""
echo "🎯 CTF Challenge Deployment Complete!"
echo "====================================="
echo ""
echo "Challenge: Corporate Data Breach"
echo "Difficulty: Intermediate"
echo "Points: 500"
echo ""
echo "Access Points:"
echo "- Web Application: http://localhost:8080"
echo "- Debug Endpoint: http://localhost:8080/debug"
echo "- Server Info: http://localhost:8080/info"
echo ""
echo "Network Information:"
echo "- DMZ Network: 10.1.1.0/24"
echo "- Internal Network: 10.1.2.0/24"
echo "- Web Server: 10.1.1.10"
echo "- Database Server: 10.1.2.20"
echo "- Admin Panel: 10.1.2.30"
echo ""
echo "Objective: Find and capture the flag hidden in the corporate database"
echo "Flag Format: CTF{...}"
echo ""
echo "To tear down the lab, run: ./scripts/teardown.sh"
echo ""
print_success "Happy hacking! 🔍"

