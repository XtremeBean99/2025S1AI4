-- Initialize the corporate database
CREATE DATABASE IF NOT EXISTS corporate_db;
USE corporate_db;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create customer_data table (contains the flag)
CREATE TABLE customer_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    company VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    secret_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample users
INSERT INTO users (username, email, department) VALUES
('john.doe', 'john.doe@securecorp.com', 'IT'),
('jane.smith', 'jane.smith@securecorp.com', 'Security'),
('bob.wilson', 'bob.wilson@securecorp.com', 'Operations'),
('alice.brown', 'alice.brown@securecorp.com', 'Management');

-- Insert sample customer data with the flag
INSERT INTO customer_data (customer_name, company, email, phone, secret_notes) VALUES
('Michael Johnson', 'TechStart Inc', 'mjohnson@techstart.com', '555-0101', 'Regular customer, no special requirements'),
('Sarah Davis', 'Global Solutions', 'sdavis@globalsol.com', '555-0102', 'VIP customer, priority support'),
('David Lee', 'Innovation Labs', 'dlee@innovlabs.com', '555-0103', 'CTF{exposed_db_credentials_are_dangerous_123}'),
('Emma Wilson', 'Future Systems', 'ewilson@futuresys.com', '555-0104', 'New customer, requires onboarding'),
('James Taylor', 'Secure Enterprises', 'jtaylor@secureent.com', '555-0105', 'Long-term contract, annual review due');

-- Create a view for public customer information (without secrets)
CREATE VIEW public_customers AS
SELECT id, customer_name, company, email, phone, created_at
FROM customer_data;

-- Grant permissions to webapp user
GRANT SELECT, INSERT, UPDATE ON corporate_db.users TO 'webapp'@'%';
GRANT SELECT ON corporate_db.public_customers TO 'webapp'@'%';
GRANT SELECT ON corporate_db.customer_data TO 'webapp'@'%';

FLUSH PRIVILEGES;

