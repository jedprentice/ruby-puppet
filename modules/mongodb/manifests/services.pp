# Defines the MongoDB services
class mongodb::services {
  service { 'mongod':
    ensure => running,
    enable => true,
    hasrestart => true,
  }
}

