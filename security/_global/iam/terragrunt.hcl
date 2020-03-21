terraform {
  source = "git@github.com/<YOUR_ORG>/infrastructure-modules.git//security/iam?ref=v0.3.0"
}

inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your security AWS account
  aws_region     = "us-east-2"
  aws_account_id = "444444444444"

  # Make sure to require MFA for all policies used in these IAM groups
  should_require_mfa = true

  # Allow the other child accounts to check IAM group membership for authenticating SSH requests with ssh-grunt
  allow_ssh_grunt_access_from_other_account_arns = [
    "arn:aws:iam::666666666666:root", # dev
    "arn:aws:iam::777777777777:root", # stage
    "arn:aws:iam::888888888888:root", # prod
    "arn:aws:iam::999999999999:root", # shared-services
  ]

  # The only IAM groups you need in the security account are full access (for admins) and a group that allows access to
  # other AWS accounts
  should_create_iam_group_full_access = true
  iam_groups_for_cross_account_access = [
    {
     group_name   = "_account.dev-full-access"
     iam_role_arn = "arn:aws:iam::666666666666:role/allow-full-access-from-other-accounts"
    },
    {
     group_name   = "_account.dev-read-only-access"
     iam_role_arn = "arn:aws:iam::666666666666:role/allow-read-only-access-from-other-accounts"
    },
    {
     group_name   = "_account.dev-dev-access"
     iam_role_arn = "arn:aws:iam::666666666666:role/allow-dev-access-from-other-accounts"
    },
    {
     group_name   = "_account.stage-full-access"
     iam_role_arn = "arn:aws:iam::777777777777:role/allow-full-access-from-other-accounts"
    },
    {
     group_name   = "_account.stage-read-only-access"
     iam_role_arn = "arn:aws:iam::777777777777:role/allow-read-only-access-from-other-accounts"
    },
    {
     group_name   = "_account.stage-developers-access"
     iam_role_arn = "arn:aws:iam::777777777777:role/allow-developers-access-from-other-accounts"
    },
    # ... Etc ...
  ]

  # Disable all other IAM groups in the security account
  should_create_iam_group_billing                = false
  should_create_iam_group_developers             = false
  should_create_iam_group_read_only              = false
  should_create_iam_group_use_existing_iam_roles = false
  should_create_iam_group_auto_deploy            = false
  should_create_iam_group_houston_cli_users      = false
  should_create_iam_group_user_self_mgmt         = false

  # Define the IAM users you want in the security account
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

    chris = {
      groups               = ["_account.dev-full-access", "_account.stage-read-only-access", "_account.prod-read-only-access"]
      pgp_key              = "keybase:chris"
      create_login_profile = true
    }

    dan = {
      groups               = ["_account.dev-full-access", "_account.stage-read-only-access", "_account.prod-read-only-access"]
      pgp_key              = "keybase:dan"
      create_login_profile = true
    }

    emily = {
      groups               = ["_account.dev-full-access", "_account.stage-full-access", "_account.prod-full-access"]
      pgp_key              = "keybase:emily"
      create_login_profile = true
    }

    # ... etc ...
  }
}

include {
  path = find_in_parent_folders()
}