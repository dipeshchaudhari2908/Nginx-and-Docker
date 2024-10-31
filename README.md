This project provides detailed steps to deploy a containerized web application on an AWS EC2 instance. The application is a simple Nginx server running inside a Docker container.






Prerequisites
AWS Account: Access to an AWS account.

AWS CLI: Installed and configured locally.

Basic Knowledge: Familiarity with Linux commands, Docker, and basic AWS concepts.






Step-by-Step Guide
Step 1: Launch an EC2 Instance
Sign in to AWS Console: Go to the AWS Management Console and log in.

Navigate to EC2: In the services menu, select EC2 under the “Compute” category.

Launch an EC2 Instance:

Security Group: Allow inbound rules for SSH (port 22) and HTTP (port 80).

Configure Key Pair for SSH Access:

Download the .pem file, as you’ll need it to SSH into the instance



Step 2: SSH into the EC2 Instance
Open Terminal:

Connect to EC2 Instance: 

ssh -i "path/to/your-key.pem" ec2-user@<Your-Instance-Public-IP>

Replace <Your-Instance-Public-IP> with the actual public IP address of the instance.



Step 3: Install Docker on the EC2 Instance
Update the Instance: 

 sudo yum update -y  # For Amazon Linux 2

# or

sudo apt update && sudo apt upgrade -y  # For Ubuntu

Install Docker: 

 sudo yum install docker -y  # For Amazon Linux 2

# or

sudo apt install docker.io -y  # For Ubuntu

Start Docker Service: 

sudo systemctl start docker

sudo systemctl enable docker

Add Current User to Docker Group:

sudo usermod -aG docker ec2-user

Verify Docker Installation:

 docker --version

If successful, Docker will be installed and ready for use.



Step 4: Create a Dockerized Web Application
Create a Project Directory: 

 mkdir webapp && cd webapp

Create a Dockerfile inside webapp directory:

 nano Dockerfile

Paste the following content into the Dockerfile:

FROM nginx:alpine

COPY ./index.html /usr/share/nginx/html/index.html

Save and exit (Ctrl + X, then Y and Enter).

Create an index.html File:

nano index.html

Add sample HTML content: 

<html>

  <head><title>Welcome to Nginx on Docker</title></head>

  <body><h1>Hello from Dockerized Nginx on EC2!</h1></body>

</html>

Save and exit. (Ctrl + X, then Y and Enter).



Step 5: Build and Run the Docker Container
Build the Docker Image:  

sudo docker build -t my-nginx .

Run the Docker Container: 

sudo docker run -d -p 80:80 my-nginx

This will map the EC2 instance’s port 80 to the container’s port 80, making the web application accessible via HTTP.

Verify the Application:

In your browser, go to http://<Your-Instance-Public-IP>.

You should see the HTML page with "Hello from Dockerized Nginx on EC2!"



Minimize image
Edit image
Delete image

Output 


If you would like to modify the content of the web application:


Step 1: Update the index.html File
Navigate to Your Project Directory:

cd webapp

Edit the index.html File:

nano index.html

Make your desired changes in the HTML content. For example, change the <h1> content:

<html>

  <head><title>Welcome to Nginx on Docker</title></head>

  <body><h1>Hello from Dockerized Nginx on EC2!</h1>

         <h2>Hi I am Dipesh Chaudhari and I am the author of this application</h2>

        <h2>I am going to create awsome documents for this!!!</h2>

</body>

</html>

Save and Exit:

Press Ctrl + X, then Y, and hit Enter to save the changes.



Step 2: Rebuild the Docker Image
Build the Docker Image Again:

docker build -t my-nginx .

This command rebuilds the Docker image with the updated index.html file.



Step 3: Stop the Existing Docker Container(if running)
List Running Containers:

docker ps

Note the Container ID or Name of the running Nginx container.

Stop the Running Container:

docker stop <container_id_or_name>

Replace <container_id_or_name> with the actual ID or name.



Step 4: Runt the Updated Docker Container
Run the Updated Docker Image:

docker run -d -p 80:80 my-nginx



Step 5: Verify the Changes
Access the Web Application:

Open a web browser and go to http://<Your-Instance-Public-IP>.

You should see the updated HTML content displayed.



Minimize image
Edit image
Delete image

After manually edit




To automate the above process:
Step 1: Create the deploy.sh Script
nano deploy.sh

Write the below code to the script file deploy.sh

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



Save and Exit:

Press Ctrl + X, then Y, and hit Enter to save the changes.



Step 2: Make the Script Executable (if not already)
If you haven't done this yet, ensure the script is executable:

chmod +x deploy.sh

Step 3: Run the Script
./deploy.sh



What the Script Does
Checks for Existing Docker Containers: The script checks if any Docker containers are running on port 80 and stops them.

Checks for Non-Docker Processes: It then checks if any non-Docker processes are using port 80 and forcefully stops them.

Builds and Runs the Docker Container: After ensuring that port 80 is free, the script builds the Docker image and runs the container.



Minimize image
Edit image
Delete image

After automation


















Used command:

sudo yum update

sudo amazon-linux-extras install docker -y

sudo yum install docker -y

clear

sudo systemctl start docker

sudo systemctl enable docker

whoami

sudo usermod -aG docker ec2-user

docker --version

mkdir webapp && cd webapp

clear

nano Dockerfile

nano index.html

docker build -t my-nginx .

sudo docker build -t my-nginx .

docker run -d -p 80:80 my-nginx

sudo docker run -d -p 80:80 my-nginx



further update on content

nano index.html

sudo docker build -t my-nginx .

sudo docker ps

sudo docker stop b1d217ea8626

sudo docker run -d -p 80:80 my-nginx





Author: Dipesh Chaudhari 
