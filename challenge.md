# Corporate Data Breach

**Category:** Network Exploitation / Misconfiguration  
**Difficulty:** Intermediate  
**Points:** 500  
**Estimated Time:** 30-45 minutes

## Challenge Description

SecureCorp, a leading provider of corporate security solutions, has recently deployed their internal web application using a containerized infrastructure. However, due to rushed deployment timelines and inadequate security reviews, several critical misconfigurations have been introduced into their production environment.

As a security researcher, you have been tasked with conducting a penetration test against SecureCorp's external-facing web application. Your objective is to identify and exploit these vulnerabilities to gain unauthorized access to sensitive customer data stored in their internal database systems.

The company's infrastructure consists of multiple network segments including a DMZ (demilitarized zone) for public-facing services and an internal network containing sensitive database servers and administrative interfaces. Through careful reconnaissance and exploitation, you must navigate these network boundaries to locate and extract the hidden flag.

## Network Architecture

The target environment simulates a realistic corporate network topology:

- **DMZ Network (10.1.1.0/24):** Contains the public-facing web server
- **Internal Network (10.1.2.0/24):** Houses the database server and administrative systems
- **Router/Firewall:** Manages traffic between network segments

## Objectives

Your primary goal is to locate and capture the flag hidden within SecureCorp's customer database. The flag follows the standard format: `CTF{...}`

## Access Information

- **Web Application:** http://localhost:8080
- **Target Network:** Multiple internal subnets accessible through the web application

## Hints

1. **Information Gathering:** Start by thoroughly exploring the web application. Look for any endpoints that might reveal system information or configuration details.

2. **Debug Interfaces:** Development teams sometimes leave debugging features enabled in production environments. These can be goldmines for sensitive information disclosure.

3. **Network Reconnaissance:** Once you gather initial information, consider what internal services might be accessible and how you could reach them.

4. **Database Access:** Corporate applications often require database connectivity. Look for any exposed credentials or connection strings that might grant you direct database access.

5. **Data Exploration:** When you gain database access, remember that sensitive information might be stored in unexpected places. Explore all available tables and their contents.

## Expected Flag Format

`CTF{exposed_db_credentials_are_dangerous_123}`

## Submission

Submit the complete flag including the `CTF{...}` wrapper when you successfully extract it from the target system.

## Learning Outcomes

Upon completing this challenge, participants will have gained practical experience with:

- Web application reconnaissance and information gathering
- Identifying and exploiting information disclosure vulnerabilities
- Network pivoting and lateral movement techniques
- Database enumeration and data extraction
- Understanding the importance of proper network segmentation and access controls

## Difficulty Justification

This challenge is rated as **Intermediate** because it requires:

- Basic understanding of web application security concepts
- Familiarity with network reconnaissance techniques
- Knowledge of database systems and SQL queries
- Ability to chain multiple vulnerabilities for successful exploitation

The challenge does not require advanced exploitation techniques or custom tool development, making it accessible to students with foundational cybersecurity knowledge while still providing valuable learning opportunities.

---

*Challenge created for educational purposes. All vulnerabilities demonstrated are intentional and designed to teach important security concepts in a safe, controlled environment.*

