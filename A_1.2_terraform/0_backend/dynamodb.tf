module "remote_state_dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = var.remote_state_dynamodb_table_name
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Terraform = "true"
  }
}