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
- `str config = p6df::modules::gcp::prompt::mod()`

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

##### p6df-gcp/lib/workspace.sh

- `p6df::modules::gcp::workspace::delegation::setup(delegated_email)`
  - Args:
    - delegated_email
- `p6df::modules::gcp::workspace::dwd::admin::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::admin::groups::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::admin::orgunits::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::admin::reports::audit::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::admin::reports::usage::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::all::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::analytics::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::calendar::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::chat::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::chat::memberships::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::chat::spaces::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::classroom::coursework::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::classroom::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::classroom::rosters::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::contacts::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::docs::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::drive::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::forms::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::gmail::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::meet::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::sheets::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::slides::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::tasks::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `p6df::modules::gcp::workspace::dwd::vault::get(sa_key_file, email)`
  - Args:
    - sa_key_file
    - email
- `str {token} = p6df::modules::gcp::workspace::admin::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::admin::groups::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::admin::orgunits::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::admin::reports::audit::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::admin::reports::usage::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::analytics::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::calendar::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::chat::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::chat::memberships::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::chat::spaces::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::classroom::coursework::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::classroom::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::classroom::rosters::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::contacts::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::docs::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::drive::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::forms::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::gmail::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::meet::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::sheets::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::slides::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::tasks::get(email)`
  - Args:
    - email
- `str {token} = p6df::modules::gcp::workspace::vault::get(email)`
  - Args:
    - email

## Hierarchy

```text
.
├── init.zsh
├── lib
│   ├── auth.sh
│   ├── config.sh
│   └── workspace.sh
└── README.md

2 directories, 5 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
