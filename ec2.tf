# data "tls_private_key" "example" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# data "tls_public_key" "example" {
#   private_key_pem = data.tls_private_key.example.private_key_pem
# }

# # Create key pair
# resource "aws_key_pair" "example" {
#   key_name   = "my-keypair"
#   public_key = data.tls_public_key.example.public_key_openssh
# }


# # Create key pair
# resource "aws_key_pair" "example" {
#   key_name   = "my-keypair"
#   public_key = file("~/.ssh/my-keypair.pub")
# }

# data "aws_key_pair" "example" {
#   key_name = "my-keypair"
# }

output "public_key" {
  value = aws_key_pair.example.public_key
}


resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "example" {
  key_name   = "karuneshst-keypair"
  public_key = tls_private_key.example.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.example.private_key_pem}' > ./myKey.pem"
  }
}

#Either we can use above provisioner or use below resource to get the pem file 
# resource "local_file" "ssh_key" {
#   filename = "${aws_key_pair.kp.key_name}.pem"
#   content = tls_private_key.pk.private_key_pem
# }

# Launch instances
resource "aws_instance" "bastion" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
    # subnet_id     = aws_subnet.public_a.id
  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = aws_subnet.private_a.id
  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "app" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  subnet_id              = aws_subnet.private_a.id
  tags = {
    Name = "app"
  }
}