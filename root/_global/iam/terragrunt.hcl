terraform {
  source = "git@github.com/<YOUR_ORG>/infrastructure-modules.git//security/iam?ref=v0.3.0"
}

inputs = {
  # Fill in your region you want to use (only used for API calls) and the ID of your root AWS account
  aws_region     = "us-east-2"
  aws_account_id = "111122223333"

  should_require_mfa = true
  user_groups = [
    {
      group_name = "billing"
      user_profiles = [
        {
          user_name = "Jim",
          pgp_key   = "keybase:jim"
        },
      ]
    },
    {
      group_name = "full_access"
      user_profiles = [
        {
          user_name = "Tony",
          pgp_key   = "keybase:tony"
        },
      ]
    }
  ]
}

include {
  path = find_in_parent_folders()
}