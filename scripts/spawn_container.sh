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

echo "Creating network bridge"
sudo docker network create --subnet=172.30.0.0/24 bridge-subas-script-172.30.0.0-sl-24 --driver bridge

# Start container database
echo "==creating database container===="

sudo docker run  -itd --name tododb-container -e POSTGRES_USER=subash  -e POSTGRES_PASSWORD=subash@123 -e POSTGRES_DB=tododb --network=bridge-subas-script-172.30.0.0-sl-24 --ip 172.30.0.2 -p 5432:5432 subash729/todo-database:stable
sleep 50
# Start container Backend
echo "==creating backend container===="
sudo docker run -itd --name todoback-container --network=bridge-subas-script-172.30.0.0-sl-24 --ip 172.30.0.3  --env-file /home/ec2-user/secret/.env  -p 3000:3000 subash729/todo-backend:stable

# Start container front
echo "==creating frontend container===="
sudo docker run -itd --name todofront-container --network=bridge-subas-script-172.30.0.0-sl-24 --ip 172.30.0.4  -p 5173:5173 subash729/todo-frontend:stable

echo " "
echo " "
echo "Containers spawned successfully! and list is"
echo "======================"
sudo docker ps -a