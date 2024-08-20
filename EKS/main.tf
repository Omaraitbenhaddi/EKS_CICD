# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks_vpc"
  cidr = var.eks_cidr

  azs                = data.aws_availability_zones.azs.names
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1

  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/private_elb"       = 1

  }
}


# eks 

module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.30"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size        = 1
      max_size        = 3
      desired_size    = 2
      instances_types = var.instances_types
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}



data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}