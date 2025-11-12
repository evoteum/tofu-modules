locals {
  enabled_workflows = {
    for workflow, condition in local.workflow_conditions :
    workflow => true
    if alltrue([
      for condition_key, required_value in condition :
      required_value == "EXISTS" ?
      try(var.repository_configuration[condition_key], null) != null :
      can(tolist(required_value)) ?
      try(var.repository_configuration[condition_key], null) != null &&
      contains(required_value, try(var.repository_configuration[condition_key], "")) :
      can(tobool(try(var.repository_configuration[condition_key], null))) && can(tobool(required_value)) ?
      tobool(try(var.repository_configuration[condition_key], null)) == tobool(required_value) :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}
