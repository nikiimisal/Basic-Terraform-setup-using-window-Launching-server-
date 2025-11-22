#Launch single instance
----------------------------------------

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-windows-demo"
  }
}


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Launch instance with creating key
----------------------------------------

# SSH after creation:
# ssh -i ~/.ssh/id_rsa ec2-user@<PUBLIC_IP>

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "deployer" {
  ami           = "ami-03695d52f0d883f65"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.my-secure.id]

  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "deployer"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Launch instance with security group 

----------------------------------------

provider "aws" {
    region = "eu-north-1"
}
resource "aws_instance" "myweb" {
  ami = "ami-0f50f13aefb6c0a5d"
  instance_type = "t3.micro"
  key_name = "server1"
  # use existing security group(created via aws console)
  vpc_security_group_ids = [aws_security_group.my-sg.id] # this is how you can refer the resource
  tags = {
    Name = "webapp"
  }
}
resource "aws_security_group" "my-sg" {
  name = "tf-sg"
  ingress {
    description = "allow ssh"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {                                           # in terraform ingress means inbound rule in aws
    description = "allow http"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow https"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {                                            # in terraform egress means outbound rule in aws

    description = "allow all traffic"
    to_port = 0
    from_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
 
}
