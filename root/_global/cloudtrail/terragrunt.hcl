terraform {
  source = "git@github.com/<YOUR_ORG>/infrastructure-modules.git//security/cloudtrail?ref=v0.3.1"
}

inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your root AWS account
  aws_region     = "us-east-2"
  aws_account_id = "111122223333"

  # Name the CloudTrail and S3 bucket
  cloudtrail_trail_name = "<COMPANY_NAME>-root"
  s3_bucket_name        = "<COMPANY_NAME>-root-cloudtrail"

  num_days_after_which_archive_log_data = 30
  num_days_after_which_delete_log_data  = 365

  # Who has access to the KMS master key
  kms_key_administrator_iam_arns = [
    "arn:aws:iam::<ROOT_ACCOUNT_ID>:user/<ADMIN_USERNAME>",
  ]
  kms_key_user_iam_arns = [
    "arn:aws:iam::<ROOT_ACCOUNT_ID>:user/<ADMIN_USERNAME>",
  ]
  allow_cloudtrail_access_with_iam = true

  s3_bucket_already_exists                   = false
  external_aws_account_ids_with_write_access = []

  # Only set this to true if, when running 'terragrunt destroy,' you want to delete the contents of the S3 bucket that
  # stores the CloudTrail logs. Note that you must set this to true and run 'terragrunt apply' FIRST, before running 'destroy'.
  force_destroy = false
}

include {
  path = find_in_parent_folders()
}