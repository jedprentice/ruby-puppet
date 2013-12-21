# Installs ruby-build globally
class rbenv::ruby_build { 
  $ruby_build_clone = '/var/tmp/ruby-build'
  
  exec { 'clone_ruby_build':
    command => 'git clone git://github.com/sstephenson/ruby-build.git',
    cwd => '/var/tmp',
    path => '/usr/bin',
    creates => $ruby_build_clone,
  }

  exec { 'install_ruby_build':
    command => "${ruby_build_clone}/install.sh",
    cwd => $ruby_build_clone,
    creates => '/usr/local/bin/ruby-build',
    require => Exec['clone_ruby_build'],
  }
}

