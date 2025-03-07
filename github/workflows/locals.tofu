locals {
  workflows_with_inputs = { for key, data in data.github_repository_file.workflows :
    key => {
      required_inputs = try(data.on.workflow_call.inputs, {})
    }
  }

  workflow_inputs = { for key, workflow in local.workflows_with_inputs :
    key => { for input_name in keys(workflow.required_inputs) :
      input_name => var[input_name] if can(var[input_name])
    }
  }

}
