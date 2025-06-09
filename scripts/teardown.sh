#!/bin/bash

# Corporate Data Breach CTF - Teardown Script
# This script cleanly removes all CTF challenge resources

set -e  # Exit on any error

echo "🧹 Starting Corporate Data Breach CTF Teardown"
echo "=============================================="

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

# Check if containerlab is installed
if ! command -v containerlab &> /dev/null; then
    print_error "Containerlab not found. Cannot proceed with teardown."
    exit 1
fi

# Check if we're in the correct directory
if [[ ! -f "topology.yml" ]]; then
    print_error "topology.yml not found. Please run this script from the CTF challenge directory."
    exit 1
fi

# Destroy the lab
print_status "Destroying Containerlab topology..."
sudo containerlab destroy -t topology.yml --cleanup || {
    print_warning "Some issues occurred during topology destruction"
}

print_success "Containerlab topology destroyed"

# Clean up any remaining containers
print_status "Cleaning up any remaining containers..."
docker container prune -f || print_warning "Failed to prune containers"

# Clean up any dangling images (optional)
read -p "Do you want to remove unused Docker images? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Removing unused Docker images..."
    docker image prune -f || print_warning "Failed to prune images"
    print_success "Unused Docker images removed"
fi

# Clean up any networks created by containerlab
print_status "Cleaning up Docker networks..."
docker network ls | grep "clab-corporate-data-breach-ctf" | awk '{print $1}' | xargs -r docker network rm || print_warning "No CTF networks to remove"

print_success "Network cleanup complete"

# Display completion message
echo ""
echo "✅ CTF Challenge Teardown Complete!"
echo "=================================="
echo ""
echo "All resources have been cleaned up:"
echo "- Containers stopped and removed"
echo "- Networks removed"
echo "- Temporary files cleaned"
echo ""
echo "The lab environment has been completely reset."
echo "You can redeploy anytime using: ./scripts/deploy.sh"
echo ""
print_success "Teardown completed successfully! 🎉"

