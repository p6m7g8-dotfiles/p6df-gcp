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
  p6df::core::homebrew::cli::brew::install oauth2l

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
# Function: p6df::modules::gcp::path::init()
#
#  Environment:	 HOMEBREW_PREFIX
#>
######################################################################
p6df::modules::gcp::path::init() {

  p6_file_load "$HOMEBREW_PREFIX/share/google-cloud-sdk/bin"

  p6_return_void
}

######################################################################
#<
#
# Function: str config = p6df::modules::gcp::prompt::mod()
#
#  Returns:
#	str - config
#	str - 
#	str - gcp:\t\t  [${account}${project:+|$project}${quota_str}${age_str}]
#
#  Environment:	 HOME
#>
######################################################################
p6df::modules::gcp::prompt::mod() {

  local config="$HOME/.config/gcloud/configurations/config_default"
  p6_file_exists "$config" || { p6_return_str ""; return; }

  # Read file once — parse all keys in a single pass
  local account project quota_project
  while IFS=' = ' read -r key value _; do
    case $key in
      account)       account=$value ;;
      project)       project=$value ;;
      quota_project) quota_project=$value ;;
    esac
  done < "$config"

  [[ -z $account ]] && { p6_return_str ""; return; }

  # Abbreviate account to username only
  account="${account%%@*}"

  # Only show quota when set and differs from project
  local quota_str=""
  [[ -n $quota_project && $quota_project != "$project" ]] && quota_str="|q:$quota_project"

  # Use zsh builtins for mtime — no subshells
  zmodload -F zsh/stat b:zstat 2>/dev/null
  local -A fstat
  local age_str=""
  if zstat -H fstat "$config" 2>/dev/null; then
    local diff=$(( EPOCHSECONDS - fstat[mtime] ))
    if (( diff > 2400 )); then
      age_str="|$(p6_color_ize "red" "black" "${diff}s")"
    elif (( diff > 2100 )); then
      age_str="|$(p6_color_ize "yellow" "black" "${diff}s")"
    fi
  fi

  p6_return_str "gcp:\t\t  ${account}${project:+|$project}${quota_str}${age_str}"
}

######################################################################
#<
#
# Function: p6df::modules::gcp::mcp()
#
#>
######################################################################
p6df::modules::gcp::mcp() {

  # Workspace APIs (Drive, Gmail, Calendar, Sheets, Docs, Chat, etc.) are
  # covered by the gws CLI — no MCP server needed for those.
  # mcp-toolbox is only needed for Cloud SQL / AlloyDB / Spanner tooling.
  p6df::core::homebrew::cli::brew::install mcp-toolbox

  p6df::modules::anthropic::mcp::server::add "gcp" "mcp-toolbox"
  p6df::modules::openai::mcp::server::add "gcp" "mcp-toolbox"

  p6_return_void
}
