
#Update Your Server &  Install Required Packages

sudo apt update && sudo apt upgrade -y
sudo apt install nginx mysql-server php-fpm php-mysql unzip curl -y
sudo mysql -u root -p

#Download WordPress
cd /etc
curl -O https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress /var/www/mycoolblog



#Set Permissions
sudo chown -R www-data:www-data /var/www/mycoolblog
sudo chmod -R 755 /var/www/mycoolblog

#Create a new site config:
sudo nano /etc/nginx/sites-available/mycoolblog

#Then enable the config:

sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

#install SSL 

sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d mycoolblog.com -d www.mycoolblog.com
