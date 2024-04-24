#!/bin/bash

function print_separator {
    printf "\n%s\n" "--------------------------------------------------------------------------------"
}

function print_header {
    figlet -c -f slant "$1"
    print_separator
}

# ========== T1 : Installing Updated Figlet ====================
print_separator
print_header "1 - FIGLET"
print_separator

# Detecting Linux distribution and installing figlet
if grep -q 'Amazon Linux 2' /etc/os-release || grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 2 or Amazon Linux 3
    print_separator
    echo "Detected Amazon Linux"
    sudo amazon-linux-extras install epel -y
    sudo yum -y install figlet

elif grep -q 'Ubuntu' /etc/os-release; then
    # Ubuntu
    print_separator
    echo "Detected Ubuntu"
    sudo apt-get update
    sudo apt-get install -y figlet
elif grep -qEi 'redhat|centos' /etc/os-release; then
    # Red Hat or CentOS
    print_separator
    echo "Detected Red Hat or CentOS"
    sudo yum -y install figlet
else
    echo "Unsupported Linux distribution"
    exit 1
fi

# ========== T2 : Installing Updated Docker ====================
print_separator
print_header "2 - DOCKER"
print_separator

# Detecting Linux distribution
if grep -q 'Amazon Linux 2' /etc/os-release; then
    # Amazon Linux 2
    print_separator
    echo "Detected Amazon Linux 2"
    sudo yum update -y
    yes | sudo amazon-linux-extras install docker
    echo "Docker installed successfully"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker service started and enabled"

elif grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 3
    print_separator
    echo "Detected Amazon Linux 3"
    sudo yum update -y
    sudo yum install -y docker
    echo "Docker installed successfully"
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker service started and enabled"

elif grep -q 'Ubuntu' /etc/os-release; then
    # Ubuntu
    print_separator
    echo "Detected Ubuntu"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl wget apt-transport-https gnupg lsb-release
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

elif grep -qEi 'redhat|centos' /etc/os-release; then
    # Red Hat or CentOS
    print_separator
    echo "Detected Red Hat or CentOS"
    sudo yum -y update
    sudo yum -y install docker
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker installed successfully"
fi

# ========== T3 : Installing Updated GIT ====================
print_separator
print_header "3 - GIT"
print_separator

# Install Git
echo "Installing Git"
if grep -q 'Amazon Linux 2' /etc/os-release || grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 2 or Amazon Linux 3
    echo "Installing Git on Amazon Linux"
    yes | sudo yum install -y git
    git version

elif grep -q 'Ubuntu' /etc/os-release; then
    # Ubuntu
    echo "Installing Git on Ubuntu"
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    yes | sudo apt-get install -y git
    git --version

elif grep -qEi 'redhat|centos' /etc/os-release; then
    # Red Hat or CentOS
    echo "Installing Git on Red Hat or CentOS"
    sudo yum -y install git
    git version

else
    echo "Unsupported Linux distribution"
    exit 1
fi

# ========== T4 : Installing Updated Trivy ====================
print_separator
print_header "4 - TRIVY"
print_separator

# Install Trivy for Ubuntu
if grep -q 'Ubuntu' /etc/os-release; then
    print_separator
    echo "Installing Trivy for Ubuntu"
    sudo apt-get update
    sudo apt-get install -y wget apt-transport-https gnupg lsb-release
    sudo wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get update
    sudo apt-get install -y trivy
    trivy image --download-db-only

elif grep -q 'Amazon Linux 2' /etc/os-release || grep -q 'Amazon Linux 3' /etc/os-release; then
    # Amazon Linux 2 and 3
    echo "Installing Git on Amazon Linux 2"
    wget https://github.com/aquasecurity/trivy/releases/download/v0.50.2/trivy_0.50.2_Linux-64bit.rpm
    sudo yum localinstall -y trivy_0.50.2_Linux-64bit.rpm
    trivy image --download-db-only

elif grep -qEi 'redhat|centos' /etc/os-release; then
    print_separator
    # Trivy installation for Red Hat or CentOS
    echo "Installing Trivy for Red Hat or CentOS"
    sudo yum -y install wget
    sudo wget -O /etc/yum.repos.d/trivy.repo https://aquasecurity.github.io/trivy-repo/rpm/releases/\$releasever/\$basearch/trivy.repo
    sudo yum -y install trivy
    echo "Trivy installed successfully"
fi

print_separator
