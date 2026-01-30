data "aws_ami" "ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250610"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.ami.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.allow_public_access
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]
  source_dest_check           = var.source_dest_check
  user_data_base64            = base64encode(templatefile("${path.module}/cloud-init.tpl", {
    username = "ubuntu"
    ssh_keys = [var.public_key, tls_private_key.ssh_key.public_key_openssh]
  }))

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }

  tags = {
    environment = "${var.environment}"
    name        = "${var.name}"
  }
}