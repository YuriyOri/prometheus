#!/bin/bash
#--------------------------------------------------------------------
# Script to Install Prometheus Node_Exporter on Linux
# Tested on Ubuntu 22.04, 16.09, Amazon Linux 2023
# Developed by Yuriy Orishchak in 2024
#--------------------------------------------------------------------
# https://github.com/prometheus/node_exporter/releases


RELEASES_URL="https://github.com/prometheus/node_exporter/releases/latest"

NODE_EXPORTER_VERSION=$(curl -sI $RELEASES_URL | grep -oP 'releases/tag/v\K[0-9]+\.[0-9]+\.[0-9]+')
#NODE_EXPORTER_VERSION = 1.8.2


if [ -n "$NODE_EXPORTER_VERSION" ]; then

	cd /tmp
	wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
	tar xvfz node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
	cd node_exporter-$NODE_EXPORTER_VERSION.linux-amd64

	mv node_exporter /usr/bin/
	rm -rf /tmp/node_exporter*

	useradd -rs /bin/false node_exporter
	chown node_exporter:node_exporter /usr/bin/node_exporter


cat <<EOF> /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
After=network.target
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
ExecStart=/usr/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
EOF

	systemctl daemon-reload
	systemctl start node_exporter
	systemctl enable node_exporter
	systemctl status node_exporter
	node_exporter --version

else
	echo "Cannot find Node Exporter release version, exit!"
fi
