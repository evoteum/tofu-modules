locals {
  init_date = format(
    "%04d-%02d-%02d",
    time_static.init.year,
    time_static.init.month,
    time_static.init.day
  )
  container_repository_doc = var.artefact_type == "container" ? "docs/container_repository.md" : ""
  common_docs = [
    "docs/adr/0001-record-architecture-decisions.md",
    "docs/adr/README.md",
    "docs/README.md",
    "docs/github_variables.md",
    local.container_repository_doc,
  ]
  markdown_files = toset(compact(local.common_docs))
}

resource "time_static" "init" {}

resource "github_repository_file" "docs" {
  for_each = local.markdown_files

  repository = var.repository_name
  file       = each.value
  content = join("\n", [
    templatefile("${path.module}/templates/${each.value}", {
      ARTEFACT_TYPE               = var.artefact_type
      CONTAINER_REPO_LINK         = local.container_repo_link
      CONTROLLER_REPO_LINK        = local.controller_repo_link
      INIT_DATE                   = local.init_date
      REPOSITORY_NAME             = var.repository_name
      REPOSITORY_OWNER            = var.repository_owner
      ORGANISATION_SECRET_NAMES   = local.github_organisation_secret_names
      ORGANISATION_VARIABLE_NAMES = local.github_organisation_variable_names
      REPOSITORY_SECRET_NAMES     = local.github_repository_secret_names
      REPOSITORY_VARIABLE_NAMES   = local.github_repository_variable_names
    }),
    templatefile("${path.module}/templates/footer.md", {
      CONTROLLER_REPO_LINK = local.controller_repo_link
      }
    )
  ])
  commit_message      = "Update"
  overwrite_on_create = true
}

resource "github_repository_file" "adr_dir" {
  content    = "docs/adr"
  file       = ".adr-dir"
  repository = var.repository_name
}




