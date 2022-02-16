provider "aws"{

    region = "ap-southeast-2"

}

variable "ingressvar" {

  type = list(number)
  default = [ 80,22,443 ]
  
}


variable "egressvar" {

  type = list(number)
  default = [ 80,22,443 ]
  
}


resource "aws_instance" "WordPress-AMI" {

    ami = "ami-0a4e637babb7b0a86"
    instance_type = "t2.micro"
    key_name = "EC2website"
    security_groups = [ aws_security_group.WordPress-AMI.name ]

    tags = {
      Name = "WordPress AMI"
    }
  
}


resource "aws_security_group" "WordPress-AMI" {

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

    Name = "WordPress-SG-AMI"

  }
}