#!/usr/bin/env bash
# Simple Laravel + nginx + phpenv setup

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <domain> <project_path>"
    echo "Example: $0 dnc.localhost /home/zlnew/www/duanaga/core-api"
    exit 1
fi

DOMAIN=$1
PROJECT_PATH=$2
NGINX_CONF="/etc/nginx/sites-available/${DOMAIN}.conf"

echo "🔧 Setting up Laravel site for $DOMAIN"

# 1. Generate nginx config
sudo mkdir -p /etc/nginx/sites-available
sudo tee $NGINX_CONF > /dev/null <<EOF
server {
    listen 80;
    server_name ${DOMAIN};

    root ${PROJECT_PATH}/public;
    index index.php index.html;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
    }

    location ~ /\. {
        deny all;
    }
}
EOF

# 2. Ensure nginx.conf include sites-available
if ! grep -q "include /etc/nginx/sites-available" /etc/nginx/nginx.conf; then
    echo "✅ Adding include directive to nginx.conf"
    sudo sed -i '/http {/a \    include /etc/nginx/sites-available/*.conf;' /etc/nginx/nginx.conf
fi

# 3. Permissions fix
echo "🔑 Fixing permissions..."
sudo chown -R $(whoami):http $PROJECT_PATH
sudo find $PROJECT_PATH -type d -exec chmod 775 {} \;
sudo find $PROJECT_PATH -type f -exec chmod 664 {} \;
sudo chmod -R 775 $PROJECT_PATH/storage $PROJECT_PATH/bootstrap/cache

# 4. Ensure home dir has +x permission
HOME_DIR=$(eval echo ~$USER)
sudo chmod 751 $HOME_DIR

# 5. Restart services
echo "♻️ Restarting nginx & php-fpm..."
pkill php-fpm || true
sleep 1
phpenv exec php-fpm -D
sudo nginx -t && sudo systemctl reload nginx

# 6. Update /etc/hosts
if ! grep -q "$DOMAIN" /etc/hosts; then
    echo "127.0.0.1 $DOMAIN" | sudo tee -a /etc/hosts > /dev/null
fi

echo "✅ Done! Open http://${DOMAIN} in your browser."