# P6's POSIX.2: p6df-gcp

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

p6df module for Google Cloud Platform: `gcloud` SDK, Google Workspace CLI,
prompt integration, and MCP server (`mcp-toolbox` via brew, Google's official
GenAI Toolbox for databases: BigQuery, Cloud SQL, Spanner).

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-gcp

##### p6df-gcp/init.zsh

- `p6df::modules::gcp::completions::init()`
- `p6df::modules::gcp::deps()`
- `p6df::modules::gcp::external::brew()`
- `p6df::modules::gcp::home::symlink()`
- `p6df::modules::gcp::init(_module, dir)`
  - Args:
    - _module
    - dir
- `p6df::modules::gcp::langs()`
- `p6df::modules::gcp::mcp()`
- `p6df::modules::gcp::path::init()`
- `str str = p6df::modules::gcp::prompt::mod()`

#### p6df-gcp/lib

##### p6df-gcp/lib/gws-docs-query.sh

- `p6df::modules::gcp::gws_docs_query::main(limit, owner, ...)`
  - Args:
    - limit
    - owner
    - ...
- `p6df::modules::gcp::gws_docs_query::usage()`

## Hierarchy

```text
.
├── bin
│   └── gws-docs-query
├── init.zsh
├── lib
│   └── gws-docs-query.sh
└── README.md

3 directories, 4 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
