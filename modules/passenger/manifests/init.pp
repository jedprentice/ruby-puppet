# Installs Phusion Passenger dependencies. We will ultimately install it as a
# gem and then install the Apache module using
# passenger-install-apache2-module, but there are certain development libs we
# will need so we will install them here. We also install an Apache virtual host
# file, but we don't notify httpd because we need to install the passenger
# apache module before the restart will succeed. We also make some assumptions
# about paths and other data that may or may not be correct once the manual
# tweaks have been done.
class passenger {
  $libs = ['libcurl-devel', 'httpd-devel', 'apr-devel', 'apr-util-devel']
  package { $libs:
    ensure => installed,
  }

  # Define some variables so we can allow them to vary with environment later
  $passenger_module = '/usr/local/rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.25/buildout/apache2/mod_passenger.so'
  $passenger_root = '/usr/local/rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/passenger-4.0.25'
  $passenger_default_ruby = '/usr/local/rbenv/versions/1.9.3-p327/bin/ruby'
  $server_name = 'my.server.fqdn'
  $server_alias = 'myserver'
  $document_root = '/path/to/public'

  file { '/etc/httpd/conf.d/angular-app.conf.sample':
    ensure => present,
    content => template("${module_name}/angular-sample.conf.erb"),
  }

  file { '/etc/httpd/conf.d/passenger.conf.sample':
    ensure => present,
    content => template("${module_name}/passenger-sample.conf.erb"),
  }
}
