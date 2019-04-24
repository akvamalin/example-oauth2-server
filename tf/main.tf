provider "aws" {
    region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "oauth" {
  instance_type = "t2.nano"
  ami = "${data.aws_ami.ubuntu.id}"
  user_data = "${file("userdata.sh")}"
  key_name = "mac-user"
}