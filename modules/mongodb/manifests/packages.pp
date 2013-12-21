# Defines the packages required to install MongoDB
class mongodb::packages {
  package { ['mongo-10gen-server', 'mongo-10gen']:
    ensure => installed,
  }
}

