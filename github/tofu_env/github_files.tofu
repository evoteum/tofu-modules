resource "github_repository_file" "tofu_env" {
  content    = local.tofu_env
  file       = ".github/.tofu.env"
  repository = var.repository_name
}
