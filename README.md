# Terraform

# Build Prometheus, Grafana and Node Exporter Servers on AWS Ubuntu 20.04 for dynamic monitoring of Node Exporter servers

./network/ script:
- Creates VPC - aws_vpc
- Creates AWS subnets - aws_subnet
- Creates AWS Internet Gateway to provide access to the internet in the given VPC - aws_internet_gateway
- Creates Second Route Table and associate it with the same VPC - aws_route_table
- Associate Public Subnets with the Second Route Table - aws_route_table_association

./server/ script:
- Builds a template with Public IP's and installs the latest Node Exporter version - aws_launch_template
- Build two Auto Scaling Groups "DEV" and "PROD" using "aws_launch_template" template - aws_autoscaling_group
- Create IAM Role AmazonEC2ReadOnlyAccess so that the Prometheus Server can retrieve data from the Node Exporter servers - aws_iam_role
- Build Prometheus server with Public IP - aws_instance.prometheus
- Build Grafana server with Public IP - aws_instance.grafana


Below is the prometheus.yml configuration file for dynamic monitoring of Node Exporter servers with the following Environment=prod and Environment=dev tags:
        scrape_configs:
          - job_name      : "prometheus"
            static_configs:
              - targets: ["localhost:9090"]

          - job_name : "prod-servers"
            ec2_sd_configs:
            - port: 9100
              filters:
                - name: tag:Environment
                  values: ["prod"]  

          - job_name : "dev-servers"
            ec2_sd_configs:
            - port: 9100
              filters:
                - name: tag:Environment
                  values: ["dev"]


Access:
Node Exporter   http://<public_server_ip>:9100
Prometheus      http://<public_server_ip>:9090
Grafana         http://<public_server_ip>:3000      the default login and password are admin/admin

Public IP addresses are required to download the sources for Prometheus, Grafana, and Node Exporter.


Note: Please note that AWS servers with public IP address are usually not free.
