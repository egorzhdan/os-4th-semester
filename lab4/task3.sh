#/bin/bash

echo "*/5 * * * Tue $(pwd)/task1.sh" | crontab -
