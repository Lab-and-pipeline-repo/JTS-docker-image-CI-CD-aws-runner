#!/bin/bash
echo "List of available images"
echo "======================"
sudo docker images
echo " "
echo " "

echo "Before container creation"
echo "======================"
sudo docker ps -a
echo " "
echo " "



# Start container database
echo "==creating database container===="

sudo docker run  -itd --name tododb-container -e POSTGRES_USER=subash  -e POSTGRES_PASSWORD=subash@123 -e POSTGRES_DB=tododb --network=bridge-subas --ip 172.30.0.2 -p 5432:5432 tododb-image

# Start container Backend
echo "==creating backend container===="
sudo docker run -itd --name todoback-container --network=bridge-subas --ip 172.30.0.3  -p 3000:3000 todobackend-image

# Start container front
echo "==creating frontend container===="
sudo docker run -itd --name todofront-container --network=bridge-subas --ip 172.30.0.4  -p 5173:5173 todofrontend

echo " "
echo " "
echo "Containers spawned successfully! and list is"
echo "======================"
sudo docker ps -a
