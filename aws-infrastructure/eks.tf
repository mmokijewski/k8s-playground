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

  tags = var.tags
}