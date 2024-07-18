Project Overview
This project consists of several tasks designed to demonstrate various aspects of DevOps, including REST API creation, Dockerization, Kubernetes deployment, and cloud architecture design. Below is a summary of each task and the corresponding implementation.

Tasks
A_1.1 REST API Creation and Dockerization
REST API Development: Developed a REST API using Node.js.
Dockerization: Containerized the application using Docker.
Docker Image: Built the Docker image and pushed the latest version to a private DockerHub repository.

A_1.2 Kubernetes Cluster Deployment
Kubernetes Cluster: Created a Kubernetes cluster in an AWS environment.
Terraform: Utilized Terraform modules to manage the infrastructure, maintaining the state file and backend for consistency and version control.

A_1.3 CI/CD with GitHub Actions
Kubernetes Manifests: Wrote Kubernetes manifest files for deployment.
CI/CD Pipeline: Set up a GitHub Actions workflow for continuous integration and continuous deployment (CI/CD).

B_1.1 System Architecture Design
Scalable E-commerce Cloud Architecture
This document outlines the scalable and cost-effective cloud architecture for an e-commerce application. The architecture leverages various cloud services to handle millions of requests, manage read and write APIs, process background jobs, and integrate with external systems for querying product lists.

Architecture Overview
The architecture utilizes multiple AWS services to ensure global scalability, high availability, and cost efficiency.

Key Components
User: The end-users accessing the e-commerce platform from around the world.
Route 53: Managed DNS service for routing traffic to the closest region.
Global Accelerator: Ensures low latency by routing user requests to the nearest available region.
CDN (CloudFront): Delivers static content to users globally with low latency.
WAF (Web Application Firewall): Protects the application from common web exploits.
Kubernetes Ingress (k8-ingress): Manages external access to services in the EKS cluster.
ALB (Application Load Balancer): Distributes incoming application traffic across multiple targets in multiple Availability Zones.
Multi-region Deployment: Ensures high availability and disaster recovery by deploying the application in two regions.
EKS (Elastic Kubernetes Service): Orchestrates containerized applications.
SQS (Simple Queue Service): Decouples microservices and manages background jobs.
SNS (Simple Notification Service): Sends notifications from the application to users or other services.
Lambda: Executes code in response to events (e.g., processing background tasks).
RDS (Relational Database Service): Manages relational databases with read replicas for high availability.
DynamoDB: Provides a NoSQL database with global table replication for low latency.
ElastiCache: Caches frequently accessed data to improve read performance.
Global DynamoDB Table Replication: Ensures low-latency read and write operations by replicating tables across regions.
Architecture Diagram
The architecture diagram is located in the diagram directory in this repository.

High-level Diagram

Deployment Steps
Prerequisites
AWS Account
AWS CLI configured
Kubernetes CLI (kubectl) installed
Terraform (optional for IaC)
Steps
Set up Route 53 and Global Accelerator:

Configure Route 53 for DNS management.
Set up Global Accelerator to route traffic to the nearest region.
Deploy CloudFront and WAF:

Configure CloudFront to serve static content.
Set up WAF to protect against web exploits.
Set up EKS Clusters:

Create EKS clusters in both regions.
Deploy applications using Kubernetes manifests.
Configure ALB and Ingress:

Set up Application Load Balancers.
Configure Kubernetes Ingress for managing external access.
Deploy Databases and Caching:

Set up RDS with read replicas for relational data.
Deploy DynamoDB with global table replication for NoSQL data.
Configure ElastiCache for caching frequently accessed data.
Integrate SQS, SNS, and Lambda:

Configure SQS for message queuing.
Set up SNS for notifications.
Deploy Lambda functions for background job processing.
Conclusion
This architecture ensures that the e-commerce application can handle millions of requests with high availability and low latency. The use of multiple AWS services helps in scaling the application globally while maintaining cost efficiency.

