module "github_documentation" {
  source = "github.com/evoteum/tofu-modules//github/documentation"

  repository_name     = var.repository_name
  repository_owner    = var.organisation
  quay_repository_url = module.quay_repository.url
}
