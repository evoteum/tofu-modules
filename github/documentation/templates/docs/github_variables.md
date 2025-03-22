# GitHub Variables

GitHub Variables is convenient and cheap ($0) way to store CI/CD variables. Unfortunately, one must be an organisation
administrator in order to see the names of these variables, making it difficult for those without that permission to use them.

Here are the names of the GitHub Variables that are available for use here in the ${REPOSITORY_NAME} repo.

## Organisation
### Secrets
${ORGANISATION_SECRET_NAMES}

### Variables
${ORGANISATION_VARIABLE_NAMES}

## ${REPOSITORY_NAME} repo
These take precedence over the organisation variables.

### Secrets
${REPOSITORY_SECRET_NAMES}

### Variables
${REPOSITORY_VARIABLE_NAMES}

