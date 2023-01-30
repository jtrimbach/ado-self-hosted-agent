param AcrName string = 'acr${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location

param imageName string = 'sample/dockeragent'
param gitRepositoryUrl string = 'https://github.com/jeroen-t/ado-self-hosted-agent.git'

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: AcrName
  location: location
  sku: {
    name: 'Basic'
  }
}

module buildAdoImage 'br/public:deployment-scripts/build-acr:1.0.1' = {
  name: 'BuildAdoSelfHostedImage'
  params: {
    AcrName: AcrName
    gitRepositoryUrl: gitRepositoryUrl
    imageName: imageName
    gitBranch: 'main'
  }
}
