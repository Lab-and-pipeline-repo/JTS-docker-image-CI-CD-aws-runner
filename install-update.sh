#!/bin/bash

if grep -q 'Amazon Linux 2' /etc/os-release; then
    # Amazon Linux 2
    echo "Detected Amazon Linux 2"
    sudo yum update -y
    sudo amazon-linux-extras install docker
    echo "Docker installed successfully"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker service started and enabled"
elif grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 3
    echo "Detected Amazon Linux 3"
    sudo yum update -y
    sudo yum install -y docker
    echo "Docker installed successfully"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker service started and enabled"
elif grep -q 'Ubuntu' /etc/os-release; then
    # Ubuntu
    echo "Detected Ubuntu"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker installed successfully"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker service started and enabled"
else
    echo "Unsupported Linux distribution"
    exit 1
fi

if grep -q 'Amazon Linux 2' /etc/os-release; then
    # Amazon Linux 2
    echo "Installing Git on Amazon Linux 2"
    yes | sudo yum install -y git
    git version
    
elif grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 2
    echo "Installing Git on Amazon Linux 3"
    yes | sudo yum install -y git
    git version
    
elif grep -q 'Ubuntu' /etc/os-release; then
    # Ubuntu
    echo "Detected Ubuntu"
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update 
    yes | sudo apt-get install -y git
    git --version
else
    echo "Unsupported Linux distribution"
    exit 1
fi
