#/bin/bash

mkdir -p ~/test && echo "catalog test was created successfully" > ~/report ; touch ~/test/$(date | tr ' ' '_') ; ping www.net_nikogo.ru || echo "error: unreachable host" >> ~/report
