locals {
  # Setting a common naming convention for environments avoids having different names for the same environment.
  # For example, "prd", "production", "prod" are all the same environment.
  # Explicit is better than implicit, so we use the full name.
  environments = ["development", "staging", "production"]
}

