# Base node, installs packages that all servers need
node base {
  stage { 'init':
    before => Stage['main'],
  }

  # If we're using vagrant, we need a few extra hookups.
  if $environment == 'vagrant' {
    class { 'vagrant':
      stage => 'init',
    }
  }

  class { ['vim', 'epel']:
    stage => 'init',
  }

  package { ['telnet', 'lynx', 'wget', 'curl', 'man', 'sysstat', 'yum-utils']:
    ensure => 'installed',
  }
}

node default inherits base {
  include httpd
  include git
  include gitflow
  include mongodb
  include rbenv
  include passenger
  include nodejs
}
