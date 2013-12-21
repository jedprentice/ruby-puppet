# Installs MongoDB
class mongodb {
  include mongodb::repositories
  include mongodb::packages
  include mongodb::services

  Class['mongodb::repositories'] -> Class['mongodb::packages'] 
      -> Class['mongodb::services']
}

