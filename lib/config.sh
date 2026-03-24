# shellcheck shell=bash
######################################################################
#<
#
# Function: str {project} = p6df::modules::gcp::config::project::get()
#
#  Returns:
#	str - {project}
#
#>
######################################################################
p6df::modules::gcp::config::project::get() {

  local project
  project=$(gcloud config get-value project 2>/dev/null)

  p6_return_str "${project}"
}

######################################################################
#<
#
# Function: p6df::modules::gcp::config::project::set(project_id)
#
#  Args:
#	project_id -
#
#>
######################################################################
p6df::modules::gcp::config::project::set() {
  local project_id="${1:?requires project ID}"

  gcloud config set project "${project_id}"

  p6_return_void
}

######################################################################
#<
#
# Function: str {project} = p6df::modules::gcp::config::quota_project::get()
#
#  Returns:
#	str - {project}
#
#>
######################################################################
p6df::modules::gcp::config::quota_project::get() {

  local project
  project=$(gcloud config get-value billing/quota_project 2>/dev/null)

  p6_return_str "${project}"
}

######################################################################
#<
#
# Function: p6df::modules::gcp::config::quota_project::set(project_id)
#
#  Args:
#	project_id -
#
#>
######################################################################
p6df::modules::gcp::config::quota_project::set() {
  local project_id="${1:?requires project ID}"

  gcloud config set billing/quota_project "${project_id}"

  p6_return_void
}
