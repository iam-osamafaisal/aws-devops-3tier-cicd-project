📌 3-Tier Web Application Deployment on AWS with Full CI/CD Pipeline (Terraform + Docker + •Jenkins + ECS + RDS)
This project demonstrates a complete End-to-End DevOps Pipeline to deploy a Dockerized 3-Tier Web Application using:

• AWS ECS Fargate (Compute)
• AWS ALB (Load Balancer)
• AWS RDS MySQL (Database Tier)
• Docker & DockerHub
• Jenkins Pipeline CI/CD
• Terraform IaC for infrastructure provisioning

This repository is built end-to-end to replicate real-world enterprise architecture used in production.

🏗️ Architecture — 3-Tier + CI/CD Pipeline
![alt text](<3-Tier Architecture_diagram.png>)
![alt text](<3-Tier Architecture-diagram.png>)

🔹Overview
GitHub → Jenkins → DockerHub → Terraform → AWS (ECS + ALB + RDS)

🔹 AWS 3-Tier Infrastructure

• Web Tier: Nginx Container (Reverse Proxy)
• App Tier: Node.js Container (REST API)
• DB Tier: AWS RDS MySQL
• Load Balancing: Application Load Balancer (ALB)
• Compute: ECS Fargate (Serverless Containers)
• Network: VPC, Public & Private Subnets, Route Tables, NAT
• Security: IAM Roles, SGs, Secrets (DB creds), ALB → ECS → RDS flow

⚙️ End-to-End CI/CD Pipeline Flow

1️⃣ Developer pushes code to GitHub

git push triggers webhook → Jenkins pipeline job.

2️⃣ Jenkins CI (Continuous Integration)

• Pull latest code
• Build Docker image
• Tag with commit SHA
• Push to DockerHub
 Run terraform plan + apply

3️⃣ Terraform executes

• Updates ECS task definition with new Docker image tag
• Applies changes to ECS cluster
• Rolling deployment begins

4️⃣ ECS Fargate Deployment

• ALB health checks tasks
• ECS drains old tasks
• New tasks take full traffic without downtime

5️⃣ Application Available

User → ALB DNS → Nginx container → Node.js container → RDS DB

🐳 Docker Setup
Build the app locally:

docker-compose up --build

App available at: http://localhost:8080

🌍 Terraform Deployment
Initialize:

cd infra/
terraform init
Validate: terraform validate

Plan: terraform plan -var="image_tag=latest"

Apply: terraform apply -auto-approve -var="image_tag=latest"

🔒 Security Best Practices Implemented

• Private subnets for ECS + RDS
• DB accessible only from ECS security group
• No public DB endpoint
• IAM task execution roles
• HTTPS-ready architecture (ACM)
• Sensitive values via variables / Jenkins credentials

🧪 Health Endpoints
Node.js endpoint: /health

📦 Technologies Used

• AWS ECS Fargate
• AWS ALB
• AWS RDS
• AWS VPC
• Terraform
• Docker
• DockerHub
• Jenkins (Pipeline as Code)
• Node.js
• Nginx
• CloudWatch Logs

🌟 Why this project is special

✔ Real-world 3-tier architecture
✔ Uses ECS Fargate (no servers to manage)
✔ Clean CI/CD pipeline using Jenkins
✔ Pure IaC via Terraform
✔ Secure networking
✔ End-to-end deployment automation
✔ Perfect for Cloud / DevOps engineers

👨‍💻 Author
Osama Faisal
📍 Bangalore, India
💼 Aspiring Cloud & DevOps Engineer
🔗 GitHub: https://github.com/iam-osamafaisal
🔗 LinkedIn: https://www.linkedin.com/posts/iam-osamafaisal_aws-devops-terraform-activity-7398239579146883073-wjYL?utm_source=share&utm_medium=member_desktop&rcm=ACoAACPTxGoB2r6kmmhk0hVfm0-T_Be7Q8uFaiM
