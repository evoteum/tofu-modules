# GitHub Variables

GitHub Variables is a convenient and cheap ($0) way to store CI/CD variables for GitHub Actions. Unfortunately, unlike
most other value stores, one must be an organisation administrator just to see the names of these variables, making it
difficult for those without that permission to use them.

As we are an open source organisation, these names are already publicly available in our code, so publishing them in one
convenient location poses no additional security risk. As such, here are the names of the GitHub Variables that are
available for use within GitHub Actions here in the `${REPOSITORY_NAME}` repo.

## Organisation
### Secrets
${ORGANISATION_SECRET_NAMES}

### Variables
${ORGANISATION_VARIABLE_NAMES}

## ${REPOSITORY_NAME} repo
If a repository variable and an organisation variable share the same name, the repository variable takes precedence.

### Secrets
${REPOSITORY_SECRET_NAMES}

### Variables
${REPOSITORY_VARIABLE_NAMES}

