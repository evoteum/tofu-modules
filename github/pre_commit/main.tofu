terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    jinja = {
      source  = "NikolaLohinski/jinja"
      version = "~> 0.5.0"
    }
  }
}

locals {
  languages = var.language != null ? [var.language] : []
  tofu_hook = var.needs_tofu ? ["tofu"] : []

  tools = compact(concat(local.languages, local.tofu_hook))
}

data "jinja_template" "precommit" {
  source {
    template  = file("${path.module}/templates/pre-commit-config.yaml.j2")
    directory = path.module
  }
  context = {
    type = "json"
    data = jsonencode({
      tools = local.tools
    })
  }
}

resource "github_repository_file" "precommit_config" {
  repository          = var.repository_name
  file                = ".pre-commit-config.yaml"
  content             = data.jinja_template.precommit.result
  branch              = var.branch
  commit_message      = "update"
  overwrite_on_create = true
}
