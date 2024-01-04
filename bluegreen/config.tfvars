project = "bluegreen"

profile = ""

vpc_cidr = "10.0.0.0/16"

subnet_details = {
  public-subnet-1 = {
    az   = "ap-southeast-1a"
    cidr = "10.0.0.0/24"
  }
  public-subnet-2 = {
    az   = "ap-southeast-1b"
    cidr = "10.0.1.0/24"
  }
}

ami_id = "ami-0e4b5d31e60aa0acd"