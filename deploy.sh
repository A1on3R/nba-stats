#!/bin/bash

# Set Variables
IMAGE_NAME="dk_projections-web"
DEPLOYMENT_NAME="new-deploy"
NAMESPACE="default" # Change if using a different namespace
REMOTE_REPO="a1on3r/$IMAGE_NAME"

echo "  Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# If using Minikube’s internal Docker
if [[ $(kubectl config current-context) == "minikube" ]]; then
    echo "🛠  Using Minikube Docker environment..."
    eval $(minikube docker-env)
fi

# Push image if using a remote registry
if [[ ! -z "$REMOTE_REPO" ]]; then
    echo " Pushing image to remote registry..."
    docker tag $IMAGE_NAME:latest $REMOTE_REPO:latest
    docker push $REMOTE_REPO:latest
fi

echo " Updating Kubernetes Deployment..."
kubectl set image deployment/$DEPLOYMENT_NAME $DEPLOYMENT_NAME=$IMAGE_NAME:latest -n $NAMESPACE --record

echo " Restarting Deployment to apply changes..."
kubectl rollout restart deployment/$DEPLOYMENT_NAME -n $NAMESPACE

echo " Deployment Updated!"