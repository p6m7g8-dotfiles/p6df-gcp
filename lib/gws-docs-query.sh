#!/usr/bin/env bash

######################################################################
#<
#
# Function: p6df::modules::gcp::gws_docs_query::usage()
#
#>
######################################################################
p6df::modules::gcp::gws_docs_query::usage() {
  cat <<'USAGE'
Usage:
  gws-docs-query [options] <search text>

Search Google Docs files via the Google Workspace CLI (`gws`) Drive API.

Options:
  -n, --limit <N>        Max results (default: 20)
  -o, --owner <email>    Restrict results to owner email
  -h, --help             Show help

Examples:
  gws-docs-query "multi-currency tcq"
  gws-docs-query --owner philip@arkestro.com -n 50 "launchdarkly"
USAGE
}

######################################################################
#<
#
# Function: p6df::modules::gcp::gws_docs_query::main(limit, owner, ...)
#
#  Args:
#	limit -
#	owner -
#	... - 
#
#  Environment:	 GWS_BIN
#>
######################################################################
p6df::modules::gcp::gws_docs_query::main() {
  local gws_bin
  gws_bin="${GWS_BIN:-$(command -v gws || true)}"
  if [[ -z "$gws_bin" ]]; then
    cat <<'MSG' >&2
gws not found.
Install with:
  npm install -g @googleworkspace/cli
MSG
    return 1
  fi

  local limit=20
  local owner=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -n|--limit)
        limit="$2"; shift 2 ;;
      -o|--owner)
        owner="$2"; shift 2 ;;
      -h|--help)
        p6df::modules::gcp::gws_docs_query::usage
        return 0 ;;
      --)
        shift; break ;;
      -*)
        echo "Unknown option: $1" >&2
        p6df::modules::gcp::gws_docs_query::usage
        return 2 ;;
      *)
        break ;;
    esac
  done

  if [[ $# -lt 1 ]]; then
    p6df::modules::gcp::gws_docs_query::usage
    return 2
  fi

  local search_text="$*"

  local auth_status auth_method
  auth_status="$("$gws_bin" auth status 2>/dev/null || true)"
  auth_method="$(echo "$auth_status" | jq -r '.auth_method // "none"' 2>/dev/null)"
  if [[ "$auth_method" == "none" ]]; then
    cat <<'MSG' >&2
gws is not authenticated.
Run one of these first:
  gws auth setup
  gws auth login
MSG
    return 1
  fi

  local q
  q="mimeType=\"application/vnd.google-apps.document\" and trashed=false and fullText contains \"${search_text//\"/\\\"}\""
  if [[ -n "$owner" ]]; then
    q="$q and \"${owner//\"/\\\"}\" in owners"
  fi

  local params resp
  params="$(jq -cn \
    --arg q "$q" \
    --arg fields "files(id,name,webViewLink,modifiedTime,owners(displayName,emailAddress))" \
    --arg orderBy "modifiedTime desc" \
    --argjson pageSize "$limit" \
    '{q: $q, pageSize: $pageSize, fields: $fields, orderBy: $orderBy}')"

  resp="$("$gws_bin" drive files list --format json --params "$params")"

  if echo "$resp" | jq -e '.error' >/dev/null 2>&1; then
    echo "$resp" | jq . >&2
    return 1
  fi

  local count
  count="$(echo "$resp" | jq '.files | length')"
  if [[ "$count" == "0" ]]; then
    echo "No matching docs found."
    return 0
  fi

  echo "$resp" | jq -r '
    .files[] |
    [
      .name,
      .id,
      .modifiedTime,
      (.owners[0].emailAddress // ""),
      .webViewLink
    ] | @tsv
  ' | awk -F'\t' '{
    printf("Title: %s\nID: %s\nModified: %s\nOwner: %s\nURL: %s\n\n", $1, $2, $3, $4, $5)
  }'
}
