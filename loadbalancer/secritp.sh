#!/bin/bash
sudo tee /etc/nginx/sites-available/loadbalance <<EOF
upstream backend {
    server 192.168.23.129;
    server 192.168.23.130;
    server 192.168.23.131;
}
server {
    listen 80;
    server_name localhost;
    location / {
        proxy_pass http://backend;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/loadbalance /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl restart nginx
