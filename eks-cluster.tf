# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "18.29.1"
#   cluster_name = "myapp-eks-cluster"
#   cluster_version = "1.22"

#   subnet_ids = module.eks-myapp-vpc.private_subnets #where you want node groups/node worker to be provisioned.
#   vpc_id = module.eks-myapp-vpc.vpc_id
#   tags = {
#     enviroment = "development" #enviroment => not important
#     application = "myapp" #app name => not important
#   }

#     eks_managed_node_groups = {
#     dev = {  #my_random_name
#       min_size     = 1
#       max_size     = 3
#       desired_size = 2

#       instance_types = ["t2.small"]
#     }
#   }
# }

