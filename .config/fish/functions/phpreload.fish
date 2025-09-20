function phpreload --description "Restarts the phpenv php-fpm service"
    echo "♻️  Restarting php-fpm..."
    pkill php-fpm || true
    sleep 1
    phpenv exec php-fpm -D
    echo "✅ php-fpm has been restarted."
end
