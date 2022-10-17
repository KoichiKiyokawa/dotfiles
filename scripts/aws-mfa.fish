# Please set AWS_MFA_SERIAL environment variable to fish/local.fish e.g.
#     set -x AWS_MFA_SERIAL arn:aws:iam::123456789012:mfa/user
# Before execution, run
#     export AWS_PROFILE=<profile_name>
# Then, execute
#     source aws-mfa.fish

echo "Input mfa code:"
read CODE


set -e AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

set JSON (aws sts get-session-token --serial-number $AWS_MFA_SERIAL --token-code $CODE)

set -x AWS_ACCESS_KEY_ID (echo $JSON | jq -r '.Credentials.AccessKeyId')
set -x AWS_SECRET_ACCESS_KEY (echo $JSON | jq -r '.Credentials.SecretAccessKey')
set -x AWS_SESSION_TOKEN (echo $JSON | jq -r '.Credentials.SessionToken')


echo "Successfuly set AWS credentials to environment variables."