#!/bin/bash

# Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql git

#  Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# MySQL
sudo systemctl start mysql
sudo systemctl enable mysql

# Clone Laravel git repository
git clone https://github.com/laravel/laravel /var/www/html/laravel

# Create and configure MySQL database
sudo mysql -e "CREATE DATABASE ansibyl_db;"
sudo mysql -e "CREATE USER 'ansibyl'@'localhost' IDENTIFIED BY 'ansibyl.cloud';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ansibyl_db.* TO 'ansibyl'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Configure Apache for Laravel
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/laravel.conf
sudo sed -i 's|/var/www/html|/var/www/html/laravel/public|g' /etc/apache2/sites-available/laravel.conf
sudo a2ensite laravel.conf
sudo systemctl restart apache2

# Set ServerName in Apache configuration
sudo bash -c 'echo "ServerName localhost" >> /etc/apache2/apache2.conf'

# Restart Apache
sudo service apache2 restart


# Display deployment completion message
echo "LAMP stack deployed successfully."