param appName string
param envName string
param color string

var prefix = '${appName}-${envName}'
var siteName = '${prefix}-site'
var planName = '${prefix}-plan'

resource plan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: planName
  location: resourceGroup().location
  kind: 'app,linux'
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource site 'Microsoft.Web/sites@2020-12-01' = {
  name: siteName
  location: resourceGroup().location
  kind: 'linux,app'
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${planName}': 'Resource'
    displayName: siteName
  }
  properties: {
    serverFarmId: plan.id
  }
}

resource siteName_appsettings 'Microsoft.Web/sites/config@2015-08-01' = {
  parent: site
  name: 'appsettings'
  location: resourceGroup().location
  tags: {
    displayName: 'config'
  }
  properties: {
    EnvName: envName
    FavoriteColor: color
  }
}