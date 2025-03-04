locals {
  needs_container      = var.artifact_type == "container"

  controller_repo_link = "This repo publishes containers at [${var.management_repo_name}](${var.management_repo_url})."

}