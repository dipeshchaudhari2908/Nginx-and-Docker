#!/bin/bash

# Function to stop a running Docker container using port 80
stop_existing_container() {
    echo "Checking for existing containers using port 80..."
    CONTAINER_ID=$(sudo docker ps -q -f "expose=80")

    if [ ! -z "$CONTAINER_ID" ]; then
        echo "Stopping existing container with ID $CONTAINER_ID..."
       sudo docker stop $CONTAINER_ID
        echo "Existing container stopped."
    else
        echo "No existing Docker containers are using port 80."
    fi
}

# Function to check and stop non-Docker processes using port 80
stop_non_docker_process() {
    echo "Checking for processes using port 80..."
    PROCESS=$(sudo lsof -t -i :80)

    if [ ! -z "$PROCESS" ]; then
        echo "Stopping process with PID $PROCESS..."
        sudo kill -9 $PROCESS
        echo "Non-Docker process stopped."
    else
        echo "No non-Docker processes are using port 80."
    fi
}

# Stop existing Docker container
stop_existing_container

# Stop non-Docker processes using port 80
stop_non_docker_process

# Build the Docker image
echo "Building the Docker image..."
sudo docker build -t my-nginx .

# Run the Docker container
echo "Running the Docker container..."
sudo docker run -d -p 80:80 my-nginx

echo "Deployment complete. Access your application at http://<Your-Instance-Public-IP>"
