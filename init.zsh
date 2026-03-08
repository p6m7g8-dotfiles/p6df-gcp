# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::gcp::deps()
#
#>
######################################################################
p6df::modules::gcp::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-go
    p6m7g8-dotfiles/p6df-js
  )
}

######################################################################
#<
#
# Function: p6df::modules::gcp::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::gcp::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::gcp::external::brew()
#
#>
######################################################################
p6df::modules::gcp::external::brew() {

  p6df::core::homebrew::cli::brew::install --cask google-cloud-sdk
  p6_js_npm_global_install "@googleworkspace/cli"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::gcp::langs()
#
#>
######################################################################
p6df::modules::gcp::langs() {

  gcloud components install anthoscli beta

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::gcp::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_DIR USER
#>
######################################################################
p6df::modules::gcp::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/gcloud" ".config/gcloud"
  p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/gsutil" ".gsutil"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::gcp::path::init()
#
#  Environment:	 HOMEBREW_PREFIX
#>
######################################################################
p6df::modules::gcp::path::init() {

  local path="$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  if p6_file_exists "$path"; then
    p6_file_load "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  fi
}

######################################################################
#<
#
# Function: p6df::modules::gcp::completions::init()
#
#  Environment:	 HOMEBREW_PREFIX
#>
######################################################################
p6df::modules::gcp::completions::init() {

  p6_file_load "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
}

######################################################################
#<
#
# Function: str str = p6df::modules::gcp::prompt::mod()
#
#  Returns:
#	str - str
#
#  Environment:	 HOME
#>
######################################################################
p6df::modules::gcp::prompt::mod() {

  local str
  if p6_file_exists "$HOME/.config/gcloud/configurations/config_default"; then
    local mtime=$(p6_file_mtime "$HOME/.config/gcloud/configurations/config_default")
    local now=$(p6_date_point_now_epoch_seconds)
    local diff=$(p6_math_sub "$now" "$mtime")

    if ! p6_math_gt "$diff" "2700"; then
      local account=$(p6_file_display "$HOME"/.config/gcloud/configurations/config_default | p6_filter_kv_value account "=")
      local project=$(p6_file_display "$HOME"/.config/gcloud/configurations/config_default | p6_filter_kv_value project "=")

      local sts
      if p6_math_gt "$diff" "2400"; then
        sts=$(p6_color_ize "red" "black" "sts:\t$diff")
      elif p6_math_gt "$diff" "2100"; then
        sts=$(p6_color_ize "yellow" "black" "sts:\t$diff")
      else
        sts="sts:$diff"
      fi

      str="gcp:\t\t  _active:[$project - $account] [] () ($sts)"
    fi
  fi

  p6_return_str "$str"
}

# gcloud auth login
# gcloud config set project PROJECT_ID
# gcloud projects list
# gcloud projects describe p6m7g8
# gcloud configure-docker # Docker credential helper

######################################################################
#<
#
# Function: p6df::modules::gcp::mcp()
#
#>
######################################################################
p6df::modules::gcp::mcp() {

  p6df::core::homebrew::cli::brew::install mcp-toolbox

  # google-drive MCP: HTTP endpoint https://mcp.google.com (no install needed)

  p6_return_void
}
