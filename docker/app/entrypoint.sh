#!/bin/bash

if [ ! -d "/app/vendor" ]; then
    echo "Running composer install..."
    composer install
else
    echo "Executing migrations..."
    php yii migrate --interactive=0
fi

exec "$@"

