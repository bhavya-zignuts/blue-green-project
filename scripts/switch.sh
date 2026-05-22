#!/bin/bash

TARGET=$1

if [ "$TARGET" == "blue" ]; then

sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3001;
    }
}
EOF

elif [ "$TARGET" == "green" ]; then

sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3002;
    }
}
EOF

fi

sudo nginx -t

sudo systemctl reload nginx


echo "$TARGET is now LIVE"