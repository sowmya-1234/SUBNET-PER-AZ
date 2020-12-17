variable "region"{
  description = "Region where to want to create VPC"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "appvpc"
}

resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
    tags ={
      "Name" = var.vpc_name
    }
}

data "aws_availability_zones" "azs"{

}

variable "subnetnames"{
  type = list(string)
  default = ["s1","s2"]
}

resource "aws_subnet" "subnet" {
    /*count = length(aws_availability_zones.azs.names)*/
    count = 3
    cidr_block = "10.0.${count.index+1}.0/24"
    vpc_id = aws_vpc.vpc.id
    tags = {
      /*"Name" = "Private-10.0.${count.index + 1}.0/24"*/
      "Name" = "${var.vpc_name}_private_10.0.${count.index + 1}.0/24"
    }
    availability_zone = data.aws_availability_zones.azs.names[count.index]
 }