#!/usr/bin/bash

# Deploy
sudo git clone https://github.com/azkaban/azkaban.git /azkaban
sudo chown -R vagrant:vagrant /azkaban
cd /azkaban && sudo -u vagrant ./gradlew installDist && cd azkaban-solo-server/build/install/azkaban-solo-server/ && sudo -u vagrant ./bin/azkaban-solo-start.sh
