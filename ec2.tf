resource "aws_launch_template" "app" {
  name_prefix   = "react-template"
  image_id      = "ami-0f5ee92e2d63afc18" # Amazon Linux 2
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install docker -y
service docker start
usermod -aG docker ec2-user

aws ecr get-login-password --region ap-south-1 | \
docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com

docker run -d -p 80:80 <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/react-devops:latest
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.web_sg.id]
  }
}
