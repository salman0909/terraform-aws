resource "aws_eks_cluster" "eks" {
  name     = "eks-demo-cluster"
  version  = var.kubernetes_version
  role_arn = aws_iam_role.master.arn


  vpc_config {
    subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
  ]
}