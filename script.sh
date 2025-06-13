
#Update Your Server &  Install Required Packages

sudo apt update && sudo apt upgrade -y
sudo apt install nginx mysql-server php-fpm php-mysql unzip curl -y
sudo apt install mysql-server -y
sudo mysql_secure_installation

sudo mysql -u root -p

#Download WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

#Copy to /var/www/:

sudo mkdir -p /var/www/ #(websites name)
sudo cp -a wordpress/. /var/www/ #(websites name)


#Set Permissions
sudo chown -R www-data:www-data /var/www/ #(websites name)mycoolblog
sudo chmod -R 755 /var/www/

sudo chown -R www-data:www-data /var/www/ #(websites name)
sudo find /var/www/#(websites name) -type d -exec chmod 755 {} \;
sudo find /var/www/#(websites name) -type f -exec chmod 644 {} \;


#Create WordPress Config:
cd /var/www/ #(websites name)
cp wp-config-sample.php wp-config.php
nano wp-config.php


# Step 6: Configure Nginx
#Create server block:

sudo nano /etc/nginx/sites-available/ayonxyz.com



#Then enable the config:

sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

#install SSL 

sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d adddomain-name-without-www -d adddomain-name with www 


## must be allow your ips from your host machine, like, /etc/hosts, 
#where you have to give name and ip of your machines
#And also whenever you purchase the domain you have to see the dns config, like where you have to put your ip address.
 
