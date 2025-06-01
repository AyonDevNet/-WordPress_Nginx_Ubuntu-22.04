# WordPress Setup on Ubuntu 22.04 with Nginx, Custom Domain, SSL & Bridged Networking

---

## 📁 Server Environment
- **OS**: Ubuntu 22.04 LTS (VMware Workstation Pro 17)
- **Web Server**: Nginx  
- **PHP**: php8.1-fpm  
- **Database**: MySQL  
- **CMS**: WordPress (latest)  

---

## 🚀 Step-by-Step Setup & What You Learned

### 1. Install Required Packages
```bash
sudo apt update
sudo apt install nginx php-fpm php-mysql mysql-server unzip curl

2. Download & Configure WordPress

cd /var/www/
sudo mkdir ayonxyz.com
cd ayonxyz.com
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/* .
sudo rm -rf wordpress latest.zip
sudo cp wp-config-sample.php wp-config.php
sudo chown -R www-data:www-data /var/www/ayonxyz.com


3. Configure wp-config.php

define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'your_password');
define('DB_HOST', 'localhost');
define('WP_HOME', 'http://ayonxyz.com');
define('WP_SITEURL', 'http://ayonxyz.com');

4. Setup MySQL Database

sudo mysql -u root -p
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;


🚩 Nginx Configuration

File: /etc/nginx/sites-available/ayonxyz.com


server {
    listen 80;
    server_name ayonxyz.com www.ayonxyz.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name ayonxyz.com www.ayonxyz.com;

    ssl_certificate /etc/ssl/certs/ayonxyz-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/ayonxyz-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    root /var/www/ayonxyz.com;
    index index.php index.html index.htm;

    access_log /var/log/nginx/ayonxyz_access.log;
    error_log /var/log/nginx/ayonxyz_error.log;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}

🔐 SSL Setup (Self-Signed)

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/ayonxyz-selfsigned.key \
-out /etc/ssl/certs/ayonxyz-selfsigned.crt

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048


🌐 Local Domain Resolution
Edit the hosts file on your local desktop:

192.168.0.104 ayonxyz.com www.ayonxyz.com



🌟 WordPress Admin Panel Access
Access: http://ayonxyz.com

If domain/IP changes, update:

WordPress Admin → Settings → General

Or wp_options table in the database

🕹️ Bridged Networking
Switched from NAT to Bridged Adapter in VMware

Learned that IP changes — must reconfigure:

Hosts file

Database siteurl

Nginx config (if IP-based)

🌐 Access Issues from Mobile
Mobile devices cannot resolve local custom domains like ayonxyz.com unless:

You edit the mobile's hosts file (rooted), OR

You set up real DNS and public IP

🎮 Bonus Learning
Set up access/error logs for site

Understood try_files $uri $uri/ /index.php?$args;

Implemented HTTP to HTTPS redirection

Troubleshot WordPress caching old URLs/IPs

✅ Summary
You’ve successfully:

Deployed WordPress on Ubuntu using Nginx

Set up a custom domain locally

Enabled HTTPS using a self-signed certificate

Bridged your VM for LAN-level access

Gained real-world production deployment experience

🔜 What’s Next?
Buy a real domain (Namecheap, Cloudflare, etc.)

Use Let's Encrypt for valid SSL

Add firewall rules (UFW)

Install Fail2Ban for brute-force protection
