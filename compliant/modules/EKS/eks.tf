resource "aws_eks_cluster" "eks" {
  name = var.eks_name
  version = var.versions
  role_arn = aws_iam_role.master.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

}