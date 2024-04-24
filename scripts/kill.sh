#!/bin/bash
echo "List of container images"
echo "======================"
sudo docker  ps -a
echo " "
echo " "

# Start container database
echo "==Removing database container===="
sudo docker stop tododb-container 
sudo docker rm tododb-container

# Start container Backend
echo "==Removing backend container===="
sudo docker stop todoback-container 
sudo docker rm todoback-container


# Start container front
echo "==Removing frontend container===="
sudo docker stop todofront-container
sudo docker rm todofront-container 

echo " "
echo " "
echo "Containers killed successfully!and list is"
echo "======================"
sudo docker ps -a
