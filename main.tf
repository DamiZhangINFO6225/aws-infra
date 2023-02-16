# Create VPC
resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr_block
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id            = aws_vpc.example.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public-${count.index + 1}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.example.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private-${count.index + 1}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example"
  }
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "public"
  }
}

# Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "private"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id       = aws_subnet.public[count.index].id
  route_table_id  = aws_route_table.public.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id       = aws_subnet.private[count.index].id
  route_table_id  = aws_route_table.private.id
}
