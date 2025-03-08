locals {
  workflows_with_inputs = { for key, data in data.github_repository_file.workflows :
    key => {
      required_inputs = try(data.on.workflow_call.inputs, {})
    }
  }

  all_possible_inputs = {
    artifact_type       = var.artifact_type
    language            = var.language
    language_version    = var.language_version
    linters             = var.linters
    needs_tofu          = var.needs_tofu
    todo_issue_disabled = var.todo_issue_disabled
  }

  workflow_inputs = { for key, workflow in local.workflows_with_inputs :
    key => { for input_name in keys(workflow.required_inputs) :
      input_name => lookup(local.all_possible_inputs, input_name, null) if contains(keys(local.all_possible_inputs), input_name)
    }
  }

}
