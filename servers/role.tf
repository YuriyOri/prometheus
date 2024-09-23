###
#
# Create IAM Role AmazonEC2ReadOnlyAccess so that the Prometheus Server can retrieve data from the Node Exporter servers
#
###


# Create IAM role
resource "aws_iam_role" "ec2_readonly_role" {
  name = var.aws_iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach AmazonEC2ReadOnlyAccess to created ARN role: Prometheus-Server-EC2ReadOnly_Role 
resource "aws_iam_role_policy_attachment" "ec2_readonly_policy_attachment" {
  role       = aws_iam_role.ec2_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Create Instance Profile with IAM role 	 Instance profile ARN (to attach this role to instance)
resource "aws_iam_instance_profile" "test_profile" {
  name = aws_iam_role.ec2_readonly_role.name
  role = aws_iam_role.ec2_readonly_role.name
}

