# Corporate Data Breach CTF - Complete Project

## Project Overview
This repository contains a complete Containerlab-based CTF challenge designed for educational purposes. The challenge simulates a realistic corporate network breach scenario where students learn about information disclosure vulnerabilities, network segmentation failures, and database security concepts.

## Challenge Description
**Name:** Corporate Data Breach  
**Category:** Network Exploitation / Misconfiguration  
**Difficulty:** Intermediate  
**Points:** 500  
**Estimated Time:** 15 minutes

## Project Structure
```
ctf-challenge/
├── topology.yml                 # Containerlab topology configuration
├── challenge.md                 # Challenge description and hints
├── tutorial.md                  # Educational tutorial document
├── solution.md                  # Solution walkthrough
├── Makefile                     # Convenient management commands
├── scripts/
│   ├── deploy.sh               # Deployment automation script
│   ├── teardown.sh             # Cleanup script
│   └── test.sh                 # Environment validation script
├── containers/
│   ├── web/                    # Web server configuration
│   │   ├── nginx.conf
│   │   ├── default.conf
│   │   ├── startup.sh
│   │   └── www/
│   │       └── index.html
│   ├── database/               # Database configuration
│   │   ├── init.sql
│   │   └── my.cnf
│   └── admin/                  # Admin panel configuration
│       ├── nginx.conf
│       └── www/
│           └── index.html
├── configs/
│   └── router-startup.sh       # Router/firewall configuration
└── presentation/               # Evidence guide slides
    ├── title.html
    ├── overview.html
    └── [additional slides...]
```

## Quick Start

### Prerequisites
- Docker installed and running
- Containerlab (will be installed automatically)
- Linux environment with sudo privileges

### Deployment
```bash
# Clone or extract the project
cd ctf-challenge

# Deploy the challenge
make deploy
# OR
./scripts/deploy.sh

# Test the environment
make test

# Access the challenge
# Web Application: http://localhost:8080
```

### Teardown
```bash
# Clean up all resources
make teardown
# OR
./scripts/teardown.sh
```

## Network Architecture
- **DMZ Network (10.1.1.0/24):** Contains the web server
- **Internal Network (10.1.2.0/24):** Houses database and admin systems
- **Router/Firewall:** Manages traffic between segments (with misconfigurations)

## Learning Objectives
Students will gain hands-on experience with:
1. Web application reconnaissance and information gathering
2. Identifying and exploiting information disclosure vulnerabilities
3. Network pivoting and lateral movement techniques
4. Database enumeration and data extraction
5. Understanding network segmentation and access controls

## Vulnerability Chain
1. **Information Disclosure:** Debug endpoint exposes environment variables
2. **Network Misconfiguration:** Firewall allows DMZ to internal network access
3. **Weak Credentials:** Database uses exposed credentials
4. **Data Extraction:** Flag stored in customer database table

## Flag
`CTF{exposed_db_credentials_are_dangerous_123}`

## Educational Resources
- **challenge.md:** Complete challenge description with hints
- **tutorial.md:** Comprehensive tutorial explaining security concepts
- **solution.md:** Step-by-step solution walkthrough
- **presentation/:** Evidence guide slides for academic submission

## Real-World Relevance
This challenge demonstrates vulnerabilities commonly found in:
- Cloud metadata service exploitation (similar to Capital One breach)
- Container environment variable exposure
- Network segmentation failures
- Debug interface misconfigurations


## Technical Implementation
- **Containerlab:** Network topology orchestration
- **Docker:** Container management and isolation
- **Alpine Linux:** Lightweight base images for efficiency
- **Nginx:** Web server with intentional vulnerabilities
- **MySQL:** Database with sample data and flag
- **iptables:** Network security rules (with misconfigurations)

## Security Considerations
This environment contains intentional vulnerabilities for educational purposes:
- Debug endpoints exposing sensitive information
- Overpermissive firewall rules
- Weak database credentials
- Network segmentation failures


## Support and Troubleshooting
- Use `make status` to check container status
- Use `make test` to validate environment
- Check logs with `docker logs <container_name>`
- Ensure Docker service is running
- Verify sufficient system resources

## License and Usage
This project is created for educational purposes. All vulnerabilities are intentional and designed to teach important security concepts in a safe, controlled environment.

---

**Created for AI4 Research Assignment -  June 2025**

