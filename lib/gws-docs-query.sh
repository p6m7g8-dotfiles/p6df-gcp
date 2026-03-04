#!/usr/bin/env bash

p6df::modules::gcp::gws_docs_query::usage() {
  cat <<'USAGE'
Usage:
  gws-docs-query [options] <search text>

Search Google Workspace Docs (Google Docs files) via Drive API.

Options:
  -n, --limit <N>        Max results (default: 20)
  -o, --owner <email>    Restrict results to owner email
  -h, --help             Show help

Examples:
  gws-docs-query "multi-currency tcq"
  gws-docs-query --owner philip@arkestro.com -n 50 "launchdarkly"
USAGE
}

p6df::modules::gcp::gws_docs_query::main() {
  local gcloud_bin
  gcloud_bin="${GCLOUD_BIN:-$(command -v gcloud || true)}"
  if [[ -z "$gcloud_bin" ]]; then
    echo "gcloud not found. Install with: brew install --cask google-cloud-sdk" >&2
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

  if ! "$gcloud_bin" auth list --format='value(account)' | grep -q .; then
    cat <<'MSG' >&2
No gcloud account is logged in.
Run one of these first:
  gcloud auth login --enable-gdrive-access
MSG
    return 1
  fi

  local access_token
  access_token="$("$gcloud_bin" auth print-access-token)"

  local q
  q="mimeType='application/vnd.google-apps.document' and trashed=false and fullText contains '${search_text//\'/\\\'}'"
  if [[ -n "$owner" ]]; then
    q="$q and '${owner//\'/\\\'}' in owners"
  fi

  local enc_q
  enc_q="$(python3 - <<PY
import urllib.parse
print(urllib.parse.quote("""$q"""))
PY
)"

  local url
  url="https://www.googleapis.com/drive/v3/files?q=${enc_q}&pageSize=${limit}&fields=files(id,name,webViewLink,modifiedTime,owners(displayName,emailAddress))&orderBy=modifiedTime%20desc"

  local resp
  resp="$(curl -sS -H "Authorization: Bearer ${access_token}" "$url")"

  if echo "$resp" | jq -e '.error' >/dev/null; then
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
