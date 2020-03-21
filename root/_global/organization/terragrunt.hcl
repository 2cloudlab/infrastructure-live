terraform {
  source = "git::ssh:@github.com/2cloudlab/infrastructure-modules.git//security/organization?ref=v0.0.1"
}

inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your root AWS account
  aws_region     = "us-east-2"
  aws_account_id = "120699691161"

  # Specify the child accounts you want
  child_accounts = {
    security        = "lab1@digolds.cn"
    shared-services = "lab2@digolds.cn"
    dev             = "lab3@digolds.cn"
    stage           = "lab4@digolds.cn"
    prod            = "lab5@digolds.cn"
  }
}

include {
  path = find_in_parent_folders()
}