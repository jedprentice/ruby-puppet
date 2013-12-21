# Installs Apache/httpd
# Parameters:
#   $port         Listen port (defaults to 80)
#   $server_admin ServerAdmin email address (defaults to 
#                 serversupport@phase2technology.com)
#   $mode         'shared' or 'dedicated'
#
class httpd($port = 80, 
            $server_admin = 'serversupport@phase2technology.com',
            $mode = 'development') {
  include httpd::packages
  include httpd::services

  class { 'httpd::files':
    port => $port,
    server_admin => $server_admin,
    mode => $mode,
  }
  
  Class['httpd::packages'] -> Class['httpd::files'] ~> Class['httpd::services']
}

