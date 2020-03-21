inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your security AWS account
  aws_region     = "us-east-2"
  aws_account_id = "444444444444"

  # Name the CloudTrail and S3 bucket
  cloudtrail_trail_name = "<COMPANY_NAME>-security"
  s3_bucket_name        = "<COMPANY_NAME>-security-cloudtrail"

  num_days_after_which_archive_log_data = 30
  num_days_after_which_delete_log_data  = 365

  # Who has access to the KMS master key
  kms_key_administrator_iam_arns = [
    "arn:aws:iam::<SECURITY_ACCOUNT_ID>:user/<ADMIN_USERNAME>",
  ]
  kms_key_user_iam_arns = [
    "arn:aws:iam::<SECURITY_ACCOUNT_ID>:user/<ADMIN_USERNAME>",
  ]
  allow_cloudtrail_access_with_iam = true

  s3_bucket_already_exists                   = false

  # Give the other child accounts (dev, stage, etc) the ability to write their logs to this bucket too
  external_aws_account_ids_with_write_access = [
    "666666666666", # dev
    "777777777777", # stage
    "888888888888", # prod
    "999999999999", # shared-services
  ]

  # Only set this to true if, when running 'terragrunt destroy,' you want to delete the contents of the S3 bucket that
  # stores the CloudTrail logs. Note that you must set this to true and run 'terragrunt apply' FIRST, before running 'destroy'.
  force_destroy = false
}