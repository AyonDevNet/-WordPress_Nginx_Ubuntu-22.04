
#Update Your Server &  Install Required Packages

sudo apt update && sudo apt upgrade -y
sudo apt install nginx mysql-server php-fpm php-mysql unzip curl -y
sudo mysql -u root -p

#Download WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress /var/www/

#Set Permissions
sudo chown -R www-data:www-data /var/www/wordpress
sudo chmod -R 755 /var/www/wordpress


#Create a new site config:

sudo nano /etc/nginx/sites-available/wordpress

#Then enable the config:

sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

