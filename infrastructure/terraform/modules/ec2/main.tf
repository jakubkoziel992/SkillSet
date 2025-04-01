#ec2
resource "aws_instance" "flask-app" {

  availability_zone           = var.availability_zone
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.ec2_sg
  ]

  key_name = aws_key_pair.flask.key_name

  user_data = templatefile(
    "${path.module}/../../scripts/init_app.sh",
    {
      app_env     = var.flask_app,
      db_user     = var.username,
      db_password = var.password,
      db_host     = var.db_host,
      db_name     = var.db_name
      secret_key  = var.app_secret_key
    }
  )

  user_data_replace_on_change = true

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = var.instance_name
  }
}

resource "tls_private_key" "my_key" {
  algorithm = var.key_algorithm
  rsa_bits  = 4096
}

resource "aws_key_pair" "flask" {
  key_name   = var.key_name
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = var.key_path
  content         = tls_private_key.my_key.private_key_pem
  file_permission = var.private_key_permission
}