#!/bin/bash
#--------------------------------------------------------------------
# Script to Install Grafana Server on Linux Ubuntu (22.04, 27.09)
# Include Prometheus DataSource Configuration
# Developed by Yuriy Orishchak in 2024
#--------------------------------------------------------------------
# https://grafana.com/grafana/download

RELEASES_URL="https://grafana.com/grafana/download?platform=linux"

#Get latest Linux Grafana Version		GRAFANA_VERSION="11.2.0"
GRAFANA_VERSION=$(curl -s  https://grafana.com/grafana/download?platform=linux | grep -oP 'Version:.*?value="(\d+\.\d+\.\d+)"' | grep -oP '\d+\.\d+\.\d+')

PROMETHEUS_URL="http://${prom_ip}:9090"


if [ -n "$GRAFANA_VERSION" ]; then

    # Install the prerequisite packages
    apt-get install -y apt-transport-https software-properties-common wget
    
    # Import the GPG key
    mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
    
    # Add a repository for stable releases
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    apt-get update
    
    # Install Grafana
    apt-get install -y adduser libfontconfig1 musl
    wget https://dl.grafana.com/oss/release/grafana_$${GRAFANA_VERSION}_amd64.deb
    dpkg -i grafana_$${GRAFANA_VERSION}_amd64.deb
    
    echo "export PATH=/usr/share/grafana/bin:$PATH" >> /etc/profile


cat <<EOF> /etc/grafana/provisioning/datasources/prometheus.yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    url: $${PROMETHEUS_URL}
EOF

    systemctl daemon-reload
    systemctl enable grafana-server
    systemctl start grafana-server
    systemctl status grafana-server

else
    echo "Cannot find Grafana release version, exit!"
fi
