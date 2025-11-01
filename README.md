# Bank_Application-

A robust multi-module Banking Application built on the Java Web Stack (JSP, Servlets, JDBC), featuring secure user authentication, distinct role-based access control, and real-time transaction alerts via live email integration.

--->Key Features
This application is designed around three core modules, each providing specialized functionality:

1. Core Banking Functionality
User Authentication: Secure Login and Registration for all three user roles (User, Cashier, Admin).

Database Integration: Utilizes SQL (via JDBC) to manage user accounts, transactions, and system data.

Live Email Integration: Implements a function for sending real-time email notifications for critical events (e.g., password resets, transaction confirmations, account alerts).

2. User Module (Customer Panel)
Account Management: View account balance and detailed transaction history.

Fund Transfer: Securely transfer funds to other internal accounts.

Profile Update: Ability for users to update their personal information.

3. Cashier Module
Customer Transactions: Perform essential banking operations for customers, such as Deposits and Withdrawals.

Account Lookup: Ability to search and view customer account details to facilitate transactions.

4. Admin Module (Administrator Panel)
User Management: Full control to Create, Activate, Deactivate, or Delete user accounts.

System Oversight: Monitor and manage system-wide transactions and user activity.

Role Management: Assign and modify user roles (User, Cashier, Admin).


--->Prerequisites

To run this Banking Application locally, ensure you have the following installed and configured:

Java Development Kit (JDK): [Specify minimum version, e.g., 1.8 or higher]

Web Server/Container: Apache Tomcat [Specify minimum version, e.g., 9.x or higher]

Database Server: MySQL or PostgreSQL (or the specific SQL database used).

--->Required JAR Files:

Database Driver: The appropriate JDBC Driver JAR file (e.g., mysql-connector-java.jar).

Email Dependency: The JavaMail API (or Jakarta Mail API) JAR file for sending live email notifications
