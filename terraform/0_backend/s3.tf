module "remote_state_s3" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket        = var.remote_state_s3_name
  acl           = "private"
  force_destroy = true
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  #   lifecycle_rule = [
  #     {
  #       prevent_destroy = false
  #     }
  #   ]

  versioning = {
    enabled = true
  }

  tags = {
    Terraform = "true"
  }
}