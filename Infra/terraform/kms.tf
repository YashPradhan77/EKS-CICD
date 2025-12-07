# resource "aws_kms_key" "eks" {
#   description             = "KMS key for EKS secrets encryption"
#   enable_key_rotation     = true
#   deletion_window_in_days = 7

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "AllowRoot"
#         Effect    = "Allow"
#         Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
#         Action    = "kms:*"
#         Resource  = "*"
#       },
#       {
#         Sid    = "AllowEKSUseOfKey"
#         Effect = "Allow"
#         Principal = { Service = "eks.amazonaws.com" }
#         Action = [
#           "kms:Encrypt","kms:Decrypt","kms:DescribeKey","kms:GenerateDataKey*",
#           "kms:CreateGrant","kms:ListGrants","kms:RevokeGrant"
#         ]
#         Resource  = "*"
#         Condition = {
#           StringEquals = {
#             "kms:ViaService"   = "eks.${var.region}.amazonaws.com"
#             "kms:CallerAccount"= data.aws_caller_identity.current.account_id
#           }
#         }
#       }
#     ]
#   })
# }