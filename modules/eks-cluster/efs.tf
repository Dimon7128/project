resource "aws_efs_file_system" "my_efs" {
  creation_token = "my-efs"

  tags = {
    Name = "MyEFS"
  }
}

resource "aws_efs_mount_target" "my_efs_mount_target" {
  count           = length(var.private_subnets)
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = var.private_subnets[count.index]
  security_groups = [module.eks.cluster_security_group_id]
}


resource "aws_security_group_rule" "efs_nfs" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.efs_sg.id # This is your EFS security group
  source_security_group_id = module.eks.cluster_security_group_id # The SG associated with EKS nodes
}

resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Security group for EFS mount targets"
  vpc_id      =  var.vpc_id # Example: Assuming VPC module provides the VPC ID
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # No ingress rule here; it's defined separately in aws_security_group_rule.efs_nfs
}