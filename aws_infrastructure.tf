# Specifies the details for the base infrastructure such as VPC, subnets, etc

resource "aws_vpc" "K8S_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name            = "${var.id}_vpc"
    "Tetrate:Owner" = var.owner
  }
}

data "aws_availability_zones" "available" {}


resource "aws_subnet" "infranet" {
  count             = min(length(data.aws_availability_zones.available.names), var.server_count)
  vpc_id            = aws_vpc.K8S_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name            = "${var.id}_infra_net"
    "Tetrate:Owner" = var.owner
  }
}

resource "aws_subnet" "appnet" {
  count             = min(length(data.aws_availability_zones.available.names), var.server_count)
  vpc_id            = aws_vpc.K8S_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 32 + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name            = "${var.id}_app_net"
    "Tetrate:Owner" = var.owner
  }
}

resource "aws_subnet" "mgmtnet" {
  count             = min(length(data.aws_availability_zones.available.names), var.server_count)
  vpc_id            = aws_vpc.K8S_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 64 + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name            = "${var.id}_mgmt_net"
    "Tetrate:Owner" = var.owner
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.K8S_vpc.id

  tags = {
    Name            = "${var.id}_igw"
    "Tetrate:Owner" = var.owner
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.K8S_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name            = "${var.id}_pub_rt"
    "Tetrate:Owner" = var.owner
  }
}

resource "aws_route_table_association" "pubrta1" {
  count          = min(length(data.aws_availability_zones.available.names), var.server_count)
  subnet_id      = aws_subnet.infranet[count.index].id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_route_table_association" "pubrta2" {
  count          = min(length(data.aws_availability_zones.available.names), var.server_count)
  subnet_id      = aws_subnet.appnet[count.index].id
  route_table_id = aws_route_table.pubrt.id
}
