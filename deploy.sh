#!/bin/bash

echo "Building Docker images..."

# Set Docker environment to use minikube's Docker daemon
eval $(minikube docker-env)

# Build backend image
docker build -t nodejs-backend:latest ./backend

# Build frontend image  
docker build -t nodejs-frontend:latest ./frontend

echo "Deploying to Kubernetes..."

# Apply Kubernetes manifests
kubectl apply -f k8s/mysql.yaml
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml

echo "Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/mysql-deployment
kubectl wait --for=condition=available --timeout=300s deployment/backend-deployment
kubectl wait --for=condition=available --timeout=300s deployment/frontend-deployment

echo "Getting service URL..."
minikube service frontend-service --url

echo "Deployment complete!"
echo "Access the application at the URL shown above"