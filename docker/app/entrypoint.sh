#!/bin/bash

# Check if the /app/vendor directory exists
if [ ! -d "/app/vendor" ]; then
    echo "Running composer install..."
    composer install
else
    echo "Executing migrations..."
    # Execute migrations for the main application
    php yii migrate --interactive=0

    # Check if the /app/yii_test file exists
    if [ ! -f "/app/yii_test" ]; then
        # Execute migrations for the test application
        php yii_test migrate --interactive=0
    fi
fi

# Execute the command passed to the script
exec "$@"
