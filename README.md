
[//]: # (STANDARD README)
[//]: # (https://github.com/RichardLitt/standard-readme)
[//]: # (----------------------------------------------)
[//]: # (Uncomment optional sections as required)
[//]: # (----------------------------------------------)

[//]: # (Title)
[//]: # (Match repository name)
[//]: # (REQUIRED)

# tofu-modules


[//]: # (Banner)
[//]: # (OPTIONAL)
[//]: # (Must not have its own title)
[//]: # (Must link to local image in current repository)


[//]: # (Badges)
[//]: # (OPTIONAL)
[//]: # (Must not have its own title)


[//]: # (Short description)
[//]: # (REQUIRED)
[//]: # (An overview of the intentions of this repo)
[//]: # (Must not have its own title)
[//]: # (Must be less than 120 characters)
[//]: # (Must match GitHub's description)

Modules for OpenTofu

[//]: # (Long Description)
[//]: # (OPTIONAL)
[//]: # (Must not have its own title)
[//]: # (A detailed description of the repo)

Welcome to the **OpenTofu Modules Repository**! This repository contains reusable **OpenTofu modules** for managing infrastructure across multiple namespaces, including **AWS, GitHub, Quay and others**.

Wherever you need to define a new thing in Tofu, you can use these modules to do so. They are designed to be **reusable**, **composable** and **easy to use**. Always aim to create a new module rather than a unique resource.

[//]: # (Keep this note to help people understand how to configure this repo.)
The configuration of this repo is managed by OpenTofu in [estate-repos](https://github.com/evoteum/estate-repos).

## Table of Contents

[//]: # (REQUIRED)
[//]: # (Delete as appropriate)

1. [Security](#security)
1. [Background](#background)
1. [Install](#install)
1. [Usage](#usage)
1. [Contributing](#contributing)
1. [License](#license)

[//]: # (## Security)
[//]: # (OPTIONAL)
[//]: # (May go here if it is important to highlight security concerns.)

This repo is public and does not contain any sensitive information. All secrets are variables in the CI/CD pipeline.

[//]: # (## Background)
[//]: # (OPTIONAL)
[//]: # (Explain the motivation and abstract dependencies for this repo)

These modules are designed to be reusable and composable. They are intended to be used across multiple namespaces and to be easy to use. They are designed to be used with OpenTofu, a configuration management tool.


## Install

[//]: # (Explain how to install the thing.)
[//]: # (OPTIONAL IF documentation repo)
[//]: # (ELSE REQUIRED)

Nothing to install. Just import the modules you need into your Tofu configuration file.



## Usage
[//]: # (REQUIRED)
[//]: # (Explain what the thing does. Use screenshots and/or videos.)

The repo is organised into the directory structure `[namespace]/[resource]`.

It contains the following modules:

[//]: # (BEGIN_MODULE_TREE)
```shell
.
├── aws
│   ├── app_runner
│   ├── certificate
│   ├── cloudfront
│   ├── dynamodb
│   ├── ecs_cluster
│   ├── ecs_service
│   ├── load_balancer
│   ├── load_balancer_domain_binding
│   ├── load_balancer_target_group
│   ├── networking
│   └── s3
├── cloudflare
│   ├── record
│   ├── root_redirect
│   └── zone
├── github
│   ├── documentation
│   ├── pre_commit
│   ├── repo
│   ├── set_repository_id
│   ├── variable
│   └── workflows
├── platform
│   └── service
└── quay
    ├── org
    └── repo
```
[//]: # (END_MODULE_TREE)

To use the modules, you can import them into your Tofu configuration like so:

```tofu
module "networking" {
  source = "git@github.com:evoteum/tofu-modules.git//aws/networking?ref=main"
}
```

As these are only small modules, we have chosen not to publish them to the Tofu registry, as this would require
individual repositories for each module.

Modules use [terraform-docs](https://terraform-docs.io/) to generate README.md files.


[//]: # (Extra sections)
[//]: # (OPTIONAL)
[//]: # (This should not be called "Extra Sections".)
[//]: # (This is a space for ≥0 sections to be included,)
[//]: # (each of which must have their own titles.)


[//]: # (## API)
[//]: # (OPTIONAL)
[//]: # (Describe exported functions and objects)


[//]: # (## Maintainers)
[//]: # (OPTIONAL)
[//]: # (List maintainers for this repository)
[//]: # (along with one way of contacting them - GitHub link or email.)


[//]: # (## Thanks)
[//]: # (OPTIONAL)
[//]: # (State anyone or anything that significantly)
[//]: # (helped with the development of this project)


## Contributing
[//]: # (REQUIRED)
If you need any help, please log an issue. PRs are welcome.

## License
[//]: # (REQUIRED)

All our code is licenced under the AGPL v3.0. See the [LICENSE](LICENSE) file for details.
