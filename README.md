# 3-Tier Node.js Application

A simple 3-tier application with:
- **Frontend**: Node.js/Express serving HTML interface
- **Backend**: Node.js/Express REST API
- **Database**: MySQL

## Local Development

```bash
docker-compose up --build
```

Access at http://localhost:3000

## Minikube Deployment

1. Start minikube:
```bash
minikube start
```

2. Deploy the application:
```bash
./deploy.sh
```

3. Access the application using the URL provided by the script.

## Manual Deployment Steps

If you prefer manual deployment:

```bash
# Set Docker environment
eval $(minikube docker-env)

# Build images
docker build -t nodejs-backend:latest ./backend
docker build -t nodejs-frontend:latest ./frontend

# Deploy to Kubernetes
kubectl apply -f k8s/mysql.yaml
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml

# Get service URL
minikube service frontend-service --url
```

## Application Features

- Add users with name and email
- View all users
- Data persisted in MySQL database
- Containerized with Docker
- Kubernetes-ready manifests