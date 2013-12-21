# Installs rbenv globally
class rbenv {
  include rbenv::install
  include rbenv::ruby_build
  #include rbenv::ruby
  
  # TODO: We can't set the ruby version from Puppet because the rbenv 
  # environmental trickery is not available to puppet
  #Class['rbenv::install'] -> Class['rbenv::ruby_build'] -> Class['rbenv::ruby']
  Class['rbenv::install'] -> Class['rbenv::ruby_build']
}

