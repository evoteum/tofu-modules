locals {
  needs_container      = var.artifact_type == "container"
  controller_repo_link = "[${var.management_repo_name}](${var.management_repo_url})"
  controller_tail      = "is controlled by OpenTofu in ${local.controller_repo_link}."
  controller_type = [
    "repo",
    "file",
  ]
  controller_footer = {
    for type in local.controller_type :
    type => "This ${type} ${local.controller_tail}"
  }
}