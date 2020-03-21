terraform {
  source = "git@github.com/<YOUR_ORG>/infrastructure-modules.git//security/iam?ref=v0.3.0"
}

inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your root AWS account
  aws_region     = "us-east-2"
  aws_account_id = "111122223333"

  # Make sure to require MFA for all policies used in these IAM groups and roles
  should_require_mfa = true

  # The only IAM groups you need in the root account are full access (for admins) and billing (for the finance team)
  should_create_iam_group_full_access = true
  should_create_iam_group_billing     = true

  # Disable all other groups in the root account
  should_create_iam_group_developers             = false
  should_create_iam_group_read_only              = false
  should_create_iam_group_use_existing_iam_roles = false
  should_create_iam_group_auto_deploy            = false
  should_create_iam_group_houston_cli_users      = false
  should_create_iam_group_user_self_mgmt         = false

  # Define the IAM users you want in the root account
  users = {
    alice = {
      groups               = ["full-access"]
      pgp_key              = "keybase:alice"
      create_login_profile = true
    }

    bob = {
      groups               = ["full-access"]
      pgp_key              = "keybase:bob"
      create_login_profile = true
    }

    carol = {
      groups               = ["billing"]
      pgp_key              = "keybase:carol"
      create_login_profile = true
    }
  }
}

include {
  path = find_in_parent_folders()
}