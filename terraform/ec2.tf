resource "aws_instance" "flask-app" {
  availability_zone = "us-east-1a"
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  key_name = aws_key_pair.flask.key_name

  root_block_device {
    volume_size = "20"
  }
}

output "ec2_instance_host" {
  value = aws_instance.flask-app.public_dns
}

resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "flask" {
  key_name   = "flask-app"
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "C:\\Users\\jakub.koziel\\Downloads/flask-app.pem"
  content         = tls_private_key.my_key.private_key_pem
  file_permission = "0600"
}