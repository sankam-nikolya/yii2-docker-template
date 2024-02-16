#!/bin/bash

if [ -d "/app/vendor" ]; then
    echo "Executing migrations..."
    php yii migrate --interactive=0
fi


exec "$@"

