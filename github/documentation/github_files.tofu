locals {
  init_date = format(
    "%04d-%02d-%02d",
    time_static.init.year,
    time_static.init.month,
    time_static.init.day
  )
  container_repository_doc = var.quay_repository_url == null ? "" : "container_repository.md"
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
      ARTEFACT_TYPE       = var.artefact_type
      CONTAINER_REPO_LINK = local.container_repo_link
      INIT_DATE           = local.init_date
      REPOSITORY_NAME     = var.repository_name
      REPOSITORY_OWNER    = var.repository_owner
    }),
    file("${path.module}/templates/footer.md")
  ])
  commit_message      = "Update"
  overwrite_on_create = true
}

resource "github_repository_file" "adr_dir" {
  content    = "docs/adr"
  file       = ".adr-dir"
  repository = var.repository_name
}