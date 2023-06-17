
targetScope = 'subscription'

param envName string = 'bicep'
param color string = 'purple'
param appName string
param loc string = 'centralus'

var rgName = '${envName}-${appName}-rg'

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: loc
}

module site 'mySite.bicep' = {
  scope: rg
  name: 'site-deploy'
  params: {
    appName: appName
    color: color
    envName: envName
  }
}
