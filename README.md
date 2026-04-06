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

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-gcp

##### p6df-gcp/init.zsh

- `p6df::modules::gcp::deps()`
- `p6df::modules::gcp::external::brews()`
- `p6df::modules::gcp::langs()`
- `p6df::modules::gcp::mcp()`
- `p6df::modules::gcp::path::init(_module, _dir)`
  - Args:
    - _module
    - _dir
- `str config = p6df::modules::gcp::prompt::context()`

#### p6df-gcp/lib

##### p6df-gcp/lib/auth.sh

- `p6df::modules::gcp::auth::login(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::auth::dwd::token(sa_key_file, email, scopes)`
  - Args:
    - sa_key_file
    - email
    - scopes
- `str {token} = p6df::modules::gcp::oauth::token(email, scopes)`
  - Args:
    - email
    - scopes

##### p6df-gcp/lib/config.sh

- `p6df::modules::gcp::config::project::set(project_id)`
  - Args:
    - project_id
- `p6df::modules::gcp::config::quota_project::set(project_id)`
  - Args:
    - project_id
- `str {project} = p6df::modules::gcp::config::project::get()`
- `str {project} = p6df::modules::gcp::config::quota_project::get()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   ├── auth.sh
│   └── config.sh
└── README.md

2 directories, 4 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
