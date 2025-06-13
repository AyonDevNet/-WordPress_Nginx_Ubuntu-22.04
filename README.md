Sure bro! Here's a professional and beginner-friendly `README.md` for your GitHub project that showcases your WordPress + Nginx setup on Ubuntu with SSL and a custom domain:

---

````markdown
# 🚀 WordPress Deployment with Nginx, SSL, and Custom Domain on Ubuntu (VMware)

This project documents the step-by-step process of deploying a **WordPress website** on **Ubuntu 22.04** using **Nginx**, **MySQL**, **PHP**, and **self-signed SSL**, hosted inside **VMware Workstation Pro 17** with **Bridged Networking** and **Local Domain Mapping**.

---

## 🧰 Server Environment

- **OS**: Ubuntu 22.04 LTS (VMware)
- **Web Server**: Nginx
- **PHP**: PHP 8.1 (php8.1-fpm)
- **Database**: MySQL
- **CMS**: WordPress
- **Network**: Bridged Adapter (VMware)
- **Domain**: ayonxyz.com (Local only, mapped via `/etc/hosts`)

---

## ⚙️ Setup Instructions

### 1. Install Required Packages

```bash
sudo apt update
sudo apt install nginx php-fpm php-mysql mysql-server unzip curl
````

### 2. Configure WordPress

```bash
cd /var/www/
sudo mkdir ayonxyz.com
cd ayonxyz.com
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/* .
sudo rm -rf wordpress latest.zip
sudo cp wp-config-sample.php wp-config.php
sudo chown -R www-data:www-data /var/www/ayonxyz.com
```

### 3. Configure `wp-config.php`

Update database settings:

```php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'your_password');
define('DB_HOST', 'localhost');
define('WP_HOME', 'http://ayonxyz.com');
define('WP_SITEURL', 'http://ayonxyz.com');
```

---

## 🛠️ Database Setup

```sql
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
```

---

## 🌐 Nginx Configuration

Create file: `/etc/nginx/sites-available/ayonxyz.com`

```nginx
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
```

Enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/ayonxyz.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

---

## 🔐 SSL: Self-Signed Certificate

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/ayonxyz-selfsigned.key \
-out /etc/ssl/certs/ayonxyz-selfsigned.crt

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

---

## 🧭 Local DNS Mapping

Edit your `/etc/hosts` on host machine:

```bash
192.168.0.104 ayonxyz.com www.ayonxyz.com
```

---

## 🛡️ Final Tips

* Access WordPress admin: `http://ayonxyz.com/wp-admin`
* Update WordPress `siteurl` and `home` in MySQL if needed:

```sql
USE wordpress;
UPDATE wp_options SET option_value='http://ayonxyz.com' WHERE option_name='siteurl';
UPDATE wp_options SET option_value='http://ayonxyz.com' WHERE option_name='home';
```

---

## ✅ What You Learned

* Full LEMP stack setup on Ubuntu VM
* Self-signed SSL certificate handling
* Bridged networking in VMware
* WordPress installation and MySQL config
* Custom Nginx configuration
* Local domain mapping and access troubleshooting

---

## 📈 Next Steps

* Buy a real domain and use Namecheap or Cloudflare
* Replace self-signed SSL with Let’s Encrypt
* Harden the server with UFW, fail2ban, and secure permissions
* Automate backups and consider using Docker for portability

---

> 💬 Feel free to fork, star, or open issues. Happy hosting!

```

---

Let me know if you'd like me to save this into a file or upload it to a GitHub repo for you!
```
