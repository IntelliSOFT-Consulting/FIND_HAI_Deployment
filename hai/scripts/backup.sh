#!/bin/bash
set -e

dbContainer=hai-db-1
dbName=dhis2
dbUser=dhis
directory=/opt/backups
file="$directory/$(date +"%Y-%m-%d_%H-%M-%S").sql"


if [ ! -d "$directory" ]; then
  echo "Creating the directory $directory..."
  sudo mkdir -p $directory
fi

if [ -z "$file" ]; then
  echo "Please provide the path to the SQL file."
  exit 1
fi

# Check if the file name ends with .sql or .sql.gz. If not, exit the script.
if [[ $file != *.sql && $file != *.sql.gz ]]; then
  echo "Invalid file format. Please provide a valid SQL file format"
  exit 1
fi

# check if hai-db-1 container is running. If not, notify the user and exit the script.
if [[ $(sudo docker ps -q -f name=$dbContainer) ]]; then
  echo "Database container is running. Proceeding with the database backup..."
else
  echo "Database container is not running. Please start the database container before running this script."
  exit 1
fi

# enter the database container and create a backup of the database
echo "Creating a backup of the database..."
sudo docker exec -t $dbContainer pg_dump -U $dbUser $dbName > $file

# check if the backup file is created successfully
if [ -f "$file" ]; then
  echo "Database backup created successfully."
else
  echo "Error creating the database backup."
  exit 1
fi


