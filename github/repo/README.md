<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_file.readme](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Allow auto-merging of pull requests | `bool` | `false` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | Allow merge commits | `bool` | `true` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | Allow rebase merging | `bool` | `false` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | Allow squash merging | `bool` | `true` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Archive repository instead of deleting on destroy | `bool` | `true` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | Automatically delete the branch after merging | `bool` | `true` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | Gitignore template to use (e.g., Go, Python, Node) | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Enable GitHub discussions | `bool` | `false` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | Enable GitHub release downloads | `bool` | `true` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Enable GitHub issues | `bool` | `true` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Enable GitHub projects | `bool` | `false` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Enable GitHub wiki | `bool` | `false` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | The optional homepage URL for the repository | `string` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Mark this repository as a template repository | `bool` | `false` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | License template to use | `string` | `"agpl-3.0"` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | Message format for merge commits | `string` | `"PR_TITLE"` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | Title format for merge commits | `string` | `"MERGE_MESSAGE"` | no |
| <a name="input_repo_description"></a> [repo\_description](#input\_repo\_description) | The description of the repository | `string` | `null` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | The name of the repository | `string` | `null` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | Message format for squash merge commits | `string` | `"COMMIT_MESSAGES"` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | Title format for squash merge commits | `string` | `"COMMIT_OR_PR_TITLE"` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | A list of topics for the repository (maximum 20) | `list(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The visibility of the repository (must be 'public' or 'private') | `string` | `"public"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Enable security vulnerability alerts | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_archived"></a> [repo\_archived](#output\_repo\_archived) | Whether the repository is archived |
| <a name="output_repo_clone_url"></a> [repo\_clone\_url](#output\_repo\_clone\_url) | The HTTPS clone URL of the repository |
| <a name="output_repo_default_branch"></a> [repo\_default\_branch](#output\_repo\_default\_branch) | The default branch of the repository |
| <a name="output_repo_full_name"></a> [repo\_full\_name](#output\_repo\_full\_name) | The full name of the repository (org/repo-name) |
| <a name="output_repo_git_clone_url"></a> [repo\_git\_clone\_url](#output\_repo\_git\_clone\_url) | The Git clone URL of the repository |
| <a name="output_repo_id"></a> [repo\_id](#output\_repo\_id) | The ID of the created GitHub repository |
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | The name of the created GitHub repository |
| <a name="output_repo_ssh_clone_url"></a> [repo\_ssh\_clone\_url](#output\_repo\_ssh\_clone\_url) | The SSH clone URL of the repository |
| <a name="output_repo_topics"></a> [repo\_topics](#output\_repo\_topics) | List of topics assigned to the repository |
| <a name="output_repo_url"></a> [repo\_url](#output\_repo\_url) | The web URL of the GitHub repository |
| <a name="output_repo_visibility"></a> [repo\_visibility](#output\_repo\_visibility) | The visibility of the repository (public/private) |
<!-- END_TF_DOCS -->