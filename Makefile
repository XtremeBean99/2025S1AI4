# Corporate Data Breach CTF - Makefile
# Provides convenient commands for managing the CTF challenge

.PHONY: help deploy test teardown clean status

# Default target
help:
	@echo "Corporate Data Breach CTF - Available Commands"
	@echo "=============================================="
	@echo ""
	@echo "make deploy    - Deploy the CTF challenge environment"
	@echo "make test      - Test the deployed environment"
	@echo "make status    - Show status of running containers"
	@echo "make teardown  - Clean up and remove all resources"
	@echo "make clean     - Remove Docker images and cleanup"
	@echo "make help      - Show this help message"
	@echo ""

# Deploy the CTF challenge
deploy:
	@echo "Deploying Corporate Data Breach CTF..."
	@./scripts/deploy.sh

# Test the environment
test:
	@echo "Testing CTF environment..."
	@./scripts/test.sh

# Show container status
status:
	@echo "Container Status:"
	@sudo containerlab inspect -t topology.yml || echo "No topology deployed"

# Teardown the environment
teardown:
	@echo "Tearing down CTF environment..."
	@./scripts/teardown.sh

# Clean up everything including images
clean: teardown
	@echo "Performing deep cleanup..."
	@docker system prune -f
	@echo "Cleanup complete"

# Quick redeploy
redeploy: teardown deploy

