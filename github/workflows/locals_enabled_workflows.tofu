locals {
  # --- Condition helpers ------------------------------------------------------

  # Return true if the key exists in repository configuration
  exists_condition = {
    for key in keys(var.repository_configuration) : key => true
  }

  # --- Evaluate Each Workflow's Conditions -----------------------------------

  condition_match = {
    for name, condition in local.workflow_conditions :
    name => [
      for key, expected in condition : {
        key      = key
        expected = expected
        actual   = try(var.repository_configuration[key], null)

        matches = (
          expected == "EXISTS" ?
          contains(keys(local.exists_condition), key) :

          can(tolist(expected)) ?
          try(var.repository_configuration[key], null) != null &&
          contains(expected, try(var.repository_configuration[key], "")) :

          can(tobool(expected)) ?
          can(tobool(try(var.repository_configuration[key], null))) &&
          tobool(try(var.repository_configuration[key], null)) == tobool(expected) :

          expected == try(var.repository_configuration[key], null)
        )
      }
    ]
  }

  # --- Collapse Condition Matches into Boolean Flags -------------------------

  conditional_workflows = {
    for name, pairs in local.condition_match :
    name => (
      length(pairs) > 0 && alltrue([for p in pairs : p.matches])
    )
  }

  # --- Global Apply-to-All Flag ----------------------------------------------

  global_workflows = {
    for name, condition in local.workflow_conditions :
    name => lookup(condition, "apply_to_all", false)
  }

  # --- Final Enabled Workflow Set --------------------------------------------

  enabled_workflows = {
    for name in keys(local.workflow_conditions) :
    name => true
    if local.global_workflows[name] || local.conditional_workflows[name]
  }
}
