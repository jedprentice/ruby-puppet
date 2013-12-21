# Installs rbenv by cloning from git and adding the rbenv path variables to the
# PATH for all users.
# TODO: See if we can make this work without making $rbenv_home/shims, 
# $rbenv_home/versions, and $rbenv_home/version world-writable. On a real server
# we can work with the group permissions to accomplish this, although we might 
# have to do that manually.
class rbenv::install {
  $rbenv_home = '/usr/local/rbenv'
  
  $dependencies = [
    'gcc-c++', 'patch', 'readline', 'readline-devel', 'zlib', 'zlib-devel', 
    'libyaml-devel', 'libffi-devel', 'openssl-devel', 'make', 'bzip2', 
    'autoconf', 'automake', 'libtool', 'bison', 'psiconv-devel', 
    'libxml2-devel', 'libxslt-devel', 'sqlite', 'sqlite-devel',
  ]
  
  package { $dependencies:
    ensure => installed,
  }
  
  exec { 'clone_rbenv':
    command => 'git clone git://github.com/sstephenson/rbenv.git',
    cwd => '/usr/local',
    path => '/usr/bin',
    creates => $rbenv_home,
    require => Package[$dependencies],
  }
  
  $rbenv_profile = '/etc/profile.d/rbenv.sh'
  file { $rbenv_profile:
    ensure => present,
    source => "puppet:///modules/${module_name}/rbenv.sh",
    mode => '0644',
    owner => 'root',
    group => 'root',
    require => Exec['clone_rbenv'],
  }
  
  # TODO: we need to find a better way to do this besides 0777
  file { ["${rbenv_home}/shims", "${rbenv_home}/versions"]:
    ensure => directory,
    mode => '0777',
    require => Exec['clone_rbenv'],
  }
  
  # TODO: we need to find a better way to do this besides 0666
  file { "${rbenv_home}/version":
    ensure => present,
    mode => '0666',
    owner => 'root',
    group => 'root',
    require => Exec['clone_rbenv'],
  }
}

