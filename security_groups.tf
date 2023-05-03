# Bastion host SG
resource "aws_security_group" "bastion_sg" {
  name_prefix = "bastion-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private Instances SG
resource "aws_security_group" "private_sg" {
  name_prefix = "private-sg"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # security_groups = [aws_security_group.private_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public Web SG
resource "aws_security_group" "public_web_sg" {
  name_prefix = "public-web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}