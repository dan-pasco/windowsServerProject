provider "aws"{

    region = "ap-southeast-2"

}

variable "ingressvar" {

  type = list(number)
  default = [ 80,3389,22 ]
  
}


variable "egressvar" {

  type = list(number)
  default = [ 80,3389,22 ]
  
}


resource "aws_instance" "WindowsServer" {

    ami = "ami-0ec7f6ff826360ee9"
    instance_type = "t2.micro"
    key_name = "EC2website"
    user_data = file("script.sh")
    security_groups = [ aws_security_group.windows_server_sg.name ]

    tags = {
      Name = "Windows Server"
    }
  
}


resource "aws_security_group" "windows_server_sg" {

  name = "Allow Traffic"

  dynamic "ingress"{
    iterator = port
    for_each = var.ingressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  dynamic "egress"{
    iterator = port
    for_each = var.egressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  
  tags = {

    Name = "Allow Tls"

  }
}