#--------------------------------------------------------------------------------
#User data for public and private instances
#------------------------------------------

data "template_file" "user_data" {
  template = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<html><h1>Hello! I am $(hostname -f)</h1></html>" | sudo tee /var/www/html/index.html

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o  "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update
  EOF
}

#--------------------------------------------------------------------------------
#Public launch template
#----------------------

resource "aws_launch_template" "epam_public_launch_template" {
  name          = var.public_launch_template_name
  image_id      = var.public_instance_ami
  instance_type = var.public_instance_type
  user_data 	  = base64encode(data.template_file.user_data.rendered)

  network_interfaces {
    associate_public_ip_address = var.public_associate_public_ip
    security_groups             = var.public_security_group_id
  }

  tag_specifications {
    resource_type = var.resource_type
    tags = {
      Name = var.public_instance_name
    }
  }
}

#--------------------------------------------------------------------------------
#Public autoscaling group
#------------------------

resource "aws_autoscaling_group" "epam_public_asg" {
  name                      = var.public_asg_name
  health_check_type         = var.health_check_type
  target_group_arns         = var.public_target_group_arn

  min_size                  = var.min_instance_count
  desired_capacity          = var.desired_instance_count
  max_size                  = var.max_instance_count
  vpc_zone_identifier       = var.public_subnet_ids

  launch_template {
    id = aws_launch_template.epam_public_launch_template.id
  }
}

#--------------------------------------------------------------------------------
#Private launch template
#-----------------------
resource "aws_key_pair" "private_subnet_key" {
  key_name   = var.private_subnet_key
  public_key = var.public_key
}

resource "aws_launch_template" "epam_private_launch_template" {
  name          = var.private_launch_template_name
  image_id      = var.private_instance_ami
  instance_type = var.private_instance_type
  user_data 	= base64encode(data.template_file.user_data.rendered)
  key_name      = aws_key_pair.private_subnet_key.id

  network_interfaces {
    associate_public_ip_address = var.private_associate_public_ip
    security_groups             = var.private_security_group_id
  }

  tag_specifications {
    resource_type = var.resource_type
    tags = {
      Name = var.private_instance_name
    }
  }
}

#--------------------------------------------------------------------------------
#Private autoscaling group
#-------------------------

resource "aws_autoscaling_group" "epam_private_asg" {
  name                      = var.private_asg_name
  health_check_type         = var.health_check_type
  target_group_arns         = var.private_target_group_arn

  min_size                  = var.min_instance_count
  desired_capacity          = var.desired_instance_count
  max_size                  = var.max_instance_count
  vpc_zone_identifier       = var.private_subnet_ids

  launch_template {
    id = aws_launch_template.epam_private_launch_template.id
  }
}

#--------------------------------------------------------------------------------
#Bastion host
#------------

resource "aws_key_pair" "bastion_host_key" {
  key_name   = var.bastion_host_key
  public_key = var.bastion_public_key
}

resource "aws_instance" "epam_bastion_host" {
  ami               = var.public_instance_ami
  instance_type     = var.public_instance_type
  key_name          = aws_key_pair.bastion_host_key.id
  subnet_id         = var.bastion_subnet_id
  security_groups   = var.bastion_security_group_id

  associate_public_ip_address = true
  provisioner "file" {
    source      = "../support_files/private_instance_key.pem"
    destination = "/home/ec2-user/private_instance_key.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("../support_files/bastion_key.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = var.bastion_host_name
  }
}