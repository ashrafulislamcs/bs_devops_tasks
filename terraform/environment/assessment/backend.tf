terraform {
  backend "s3" {
    bucket         = "assessment-remote-state-s3"
    key            = "test-remote-state.tfstate"
    region         = "eu-west-1"
    encrypt        = "true"
    dynamodb_table = "assessment-remote-state-dynamodb"
  }
}