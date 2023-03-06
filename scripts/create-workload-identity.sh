githubOrganizationName='Valerio-PCG'
githubRepositoryName='bicep-auto-review'

applicationRegistrationDetails=$(az ad app create --display-name 'bicep-auto-review')
applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

az ad app federated-credential create \
   --id $applicationRegistrationObjectId \
   --parameters "{\"name\":\"bicep-end-to-end-test\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:pull_request\",\"audiences\":[\"api://AzureADTokenExchange\"]}"