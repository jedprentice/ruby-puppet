# Installs nodejs and npm.
class nodejs {
  package { 'nodejs':
    ensure => installed,
  }

  package { 'npm':
    ensure => installed,
    require => Package['nodejs'],
  }
}
