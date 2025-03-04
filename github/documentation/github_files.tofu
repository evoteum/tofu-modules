locals {
  controller_repo_link = "[${var.management_repo_name}](${var.management_repo_url})"

  container_docs = ["container_repo.md"]
  common_docs    = []

  markdown_files = compact(
    concat(
      [
        local.common_docs,
        var.artefact_type == "container" ? local.container_docs : [],
      ]
    )
  )
}


resource "github_repository_file" "markdown_docs" {
  for_each = toset(local.markdown_files)

  repository = var.repo_name
  file       = "docs/${each.value}"
  content = join("\n", [
    templatefile("${path.module}/templates/${each.value}.md", {
      repo_name           = var.repo_name
      repo_owner          = var.repo_owner
      artefact_type       = var.artefact_type
      CONTAINER_REPO_LINK = local.container_repo_link
    }),
    file("${path.module}/footer.md")
  ])
  commit_message      = "Updating ${each.value} with latest content"
  overwrite_on_create = true
}
