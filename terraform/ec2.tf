resource "aws_instance" "flask-app" {

  availability_zone = "us-east-1a"
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.skillset-web-SG.id
  ]

  key_name = aws_key_pair.flask.key_name

  user_data = templatefile(
    "../init_app.sh",
    {
      app_env     = "prod",
      db_user     = var.username,
      db_password = var.password,
      db_host     = aws_db_instance.mysql.endpoint,
      db_name     = aws_db_instance.mysql.db_name
    }
  )

  user_data_replace_on_change = true

  root_block_device {
    volume_size = "20"
  }

  tags = {
    Name = "Skillset-web"
  }
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