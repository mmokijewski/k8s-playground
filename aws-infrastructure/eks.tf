module "eks" {
  source     = "terraform-aws-modules/eks/aws"
  version    = "20.24.3"
  depends_on = [module.vpc]

  cluster_name    = "kubernetes-cluster"
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access           = true
  cluster_endpoint_private_access          = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    node_group = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.medium"]
      capacity_type  = "SPOT"

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  tags = var.tags
}