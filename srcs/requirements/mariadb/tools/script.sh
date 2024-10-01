#!/bin/bash

# Ensure proper permissions for MySQL directories
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql
chmod 777 /var/run/mysqld

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server in the background
mysqld_safe --datadir='/var/lib/mysql' &
sleep 10  # Increase the wait time to ensure it's fully initialized

# Verify MariaDB is running
if ! mysqladmin ping --silent; then
    echo "MariaDB failed to start"
    exit 1
fi

# Create the SQL file for database setup
echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%';" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

# Execute the SQL file
mysql < db1.sql

# Clean up
rm db1.sql

# Keep MariaDB running in the foreground
wait
