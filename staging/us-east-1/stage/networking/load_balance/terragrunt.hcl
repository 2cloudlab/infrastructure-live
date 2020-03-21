remote_state {
  backend = "s3"
  config = {
    bucket         = "cloudlab-terraform-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "cloudlab-lock-table-1"
  }
}