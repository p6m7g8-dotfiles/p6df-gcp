#####################################################################

######################################################################
#<
#
# Function: p6df::modules::gcp::deps()
#
#>
######################################################################
p6df::modules::gcp::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::gcp::external::brew()
#
#>
######################################################################
p6df::modules::gcp::external::brew() {

  brew install --cask google-cloud-sdk
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
}

######################################################################
#<
#
# Function: p6df::modules::gcp::home::symlink()
#
#>
######################################################################
p6df::modules::gcp::home::symlink() {

    p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/gcloud" ".config/gcloud"
    p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/gsutil" ".gsutil"
}

######################################################################
#<
#
# Function: p6df::modules::gcp::init()
#
#>
######################################################################
p6df::modules::gcp::init() {

    export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
}

######################################################################
#<
#
# Function: p6df::modules::gcp::prompt::line()
#
#>
######################################################################
p6df::modules::gcp::prompt::line() {

  p6_gcp_prompt_info
}

## XXX: move to p6gcp
######################################################################
#<
#
# Function: str str = p6_gcp_prompt_info()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6_gcp_prompt_info() {

 local str
 if p6_file_exists "$HOME/.config/gcloud/configurations/config_default"; then
      local mtime=$(p6_dt_mtime "$HOME/.config/gcloud/configurations/config_default")
      local now=$(p6_dt_now_epoch_seconds)
      local diff=$(p6_math_sub "$now" "$mtime")

      if ! p6_math_gt "$diff" "2700"; then
          local account=$(awk -F= '/account/ { print $2 }' < $HOME/.config/gcloud/configurations/config_default | sed -e 's, *,,g')   
          local project=$(awk -F= '/project/ { print $2 }' < $HOME/.config/gcloud/configurations/config_default | sed -e 's, *,,g')

          local sts
          if p6_math_gt "$diff" "2400"; then
              sts=$(p6_color_ize "red" "black" "sts:\t$diff")
          elif p6_math_gt "$diff" "2100"; then
              sts=$(p6_color_ize "yellow" "black" "sts:\t$diff")
          else
              sts="sts:$diff"
          fi

          str="gcp:      _active:[$project - $account] [] () ($sts)"
      fi
  fi

  p6_return_str "$str"
}

# gcloud auth login
# gcloud config set project PROJECT_ID
# gcloud projects list
# gcloud projects describe p6m7g8
# gcloud configure-docker # Docker credential helper
