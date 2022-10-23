provider "aws" {
  region = "eu-west-2"
}

terraform {
	required_version = ">= 0.12"
	backend "s3" {
		bucket =  "kazeem-terraform-storage" #bucketname
		key = "eks/state.tfstate" #path to storing state in s3 bucket.
		region= "eu-west-2" #where your bucket is
}
}


data "aws_availability_zones" "available" {
  state = "available"
}

module "eks-myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"
  name = "myapp-vpc"
  cidr = var.cidr_block
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true #creating nat gateway for private subnet to communicate to internet.
  single_nat_gateway = true #streams all the three private subnet to one nat gateway
  enable_dns_hostnames = true #have public ip and public dns names
  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared" #kubernetets cloud-control manager uses this to  know which vpc to talk to.
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared" #kubernetets cloud-control manager uses this to  know which subnet to talk to.
    "kubernete.io/role/elb" =1#when you create a load balancer service kubernetes creates a cloud native load balancer in public subnet
  }
private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared" #kubernetets cloud-control manager uses this to  know which subnet to talk to.
    "kubernete.io/roleinternal- elb" =1 #when you create a load balancer service kubernetes creates an internal load balancer in public subnet
}
}

