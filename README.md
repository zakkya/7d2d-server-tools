*I'm not that good in english, do not hesitate to change my words/sentences*

# 7d2d-server-tools

## discord-notification.sh

For this script, you might create a service which execute it constantly. This service should be in dependancy of your start-7d2d-server.service

I created something like this :
```
[Unit]
Description=7d2d discord notifications
After=7d2d-server.service

[Service]
ExecStart=/bin/bash /srv/scripts/discord-notification.sh

[Install]
WantedBy=multi-user.target
```
