# Defines the httpd/apache service
class httpd::services {
  service { 'httpd':
    ensure => running,
    enable => true, 
    hasrestart => true,
  }
}

