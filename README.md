# Demo: CI/CD + Docker + AWS 3-Tier Web App

**Short:** End-to-End CI/CD for a Dockerized web app deployed on AWS 3-Tier architecture (EC2 + RDS + S3).  
**Stack:** AWS (EC2, RDS, S3), Docker, Docker Compose, Jenkins, Node.js (Express), Nginx, GitHub, DockerHub

---

## Project Goals
- Implement CI/CD pipeline: GitHub → Jenkins → DockerHub → EC2 (deploy)
- Containerize frontend & backend using Docker
- Host backend database on AWS RDS (MySQL)
- Store assets/backups on S3
- Demonstrate basic monitoring via CloudWatch

---

## Repo Structure

project-root/
├─ frontend/
├─ backend/
├─ docker-compose.yml
├─ jenkins/Jenkinsfile
├─ scripts/deploy.sh
└─ README.md