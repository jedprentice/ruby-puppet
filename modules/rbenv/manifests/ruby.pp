# Installs ruby using rbenv
# TODO: This does not work because root doesn't have the right environmental 
# hookups.
class rbenv::ruby {
  $rbenv_home = '/usr/local/rbenv'
  $rbenv = "${rbenv_home}/bin/rbenv"
  $ruby_version = '2.0.0-p247'
  
  exec { 'rbenv_install':
    command => "${rbenv} install ${ruby_version}",
    creates => "${rbenv_home}/versions/${ruby_version}",
    timeout => 0,
  }
  
  exec { 'rbenv_global':
    command => "${rbenv} global ${ruby_version}",
    require => Exec['rbenv_install'],
  }
}

