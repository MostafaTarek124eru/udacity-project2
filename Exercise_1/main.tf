# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:/Users/mosta/.aws/credentials"]
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "T2" {
  count         = "4"
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-074b3778b3ffcb781"
  tags = {
    "Name" = "Udacity-T2-${count.index + 1}"
  }

}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "M4" {
  count         = "2"
  ami           = "ami-0742b4e673072066f"
  instance_type = "m4.large"
  subnet_id     = "subnet-074b3778b3ffcb781"
  tags = {
    "Name" = "Udacity-M4-${count.index + 1}"
  }

}
