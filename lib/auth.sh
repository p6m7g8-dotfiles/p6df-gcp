# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::gcp::auth::login(email)
#
#  Args:
#	email -
#
#>
######################################################################
p6df::modules::gcp::auth::login() {
  local email="${1:?requires email address}"

  gcloud auth login "${email}" --force

  p6_return_void
}

######################################################################
#<
#
# Function: str {token} = p6df::modules::gcp::oauth::token(email, scopes)
#
#  Args:
#	email -
#	scopes -
#
#  Returns:
#	str - {token}
#
#>
######################################################################
p6df::modules::gcp::oauth::token() {
  local email="${1:?requires email address}"
  local scopes="${2:?requires comma-separated scopes}"

  local token
  if ! token=$(gcloud auth print-access-token "${email}" --scopes="${scopes}" 2>/dev/null); then
    print "Scope mismatch or expired credentials — re-authenticating ${email}..."
    p6df::modules::gcp::auth::login "${email}"
    token=$(gcloud auth print-access-token "${email}" --scopes="${scopes}")
  fi

  p6_return_str "${token}"
}

######################################################################
#<
#
# Function: str {token} = p6df::modules::gcp::auth::dwd::token(sa_key_file, email, scopes)
#
#  Args:
#	sa_key_file -
#	email -
#	scopes -
#
#  Returns:
#	str - {token}
#
#>
######################################################################
p6df::modules::gcp::auth::dwd::token() {
  local sa_key_file="${1:?requires service account key file path}"
  local email="${2:?requires email address to impersonate}"
  local scopes="${3:?requires comma-separated scopes}"

  local token
  token=$(oauth2l fetch \
    --json "${sa_key_file}" \
    --scope "${scopes}" \
    --email "${email}")

  p6_return_str "${token}"
}
