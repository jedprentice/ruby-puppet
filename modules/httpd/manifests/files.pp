# Defines the fifles required by Apache/httpd.  We set a few variables
# for the template that can vary with mode.
#
# Set MaxClients as follows: 
#   $max_clients = (Physical RAM in megabytes) / (70M / httpd process)
#
# Allow for monitoring by ServerDensity or other tools:
#   $serverstatus = true
#
# Parameters:
#   $port         Listen port (defaults to 80)
#   $server_admin ServerAdmin email address (defaults to 
#                 serversupport@phase2technology.com)
#   $mode         'development', 'shared', or 'dedicated'.
#                 development: full stack
#                 shared: full web tier, shared among varnish, apache, memcache
#                 dedicated: Apache and (perhaps) memcache
#
class httpd::files($port = 80, 
                   $server_admin = 'serversupport@phase2technology.com',
                   $mode = 'development') {
  $serverstatus = true
  $httpd_root = '/etc/httpd'
  $conf_d = 'conf.d'
  $conf_dir = "${httpd_root}/${conf_d}"
  $doc_root = '/var/www/html'
  $ssl_port = 443
  
  file { $conf_dir:
    ensure => directory,
  }

  # Use fully-qualified domain name as the server name if available,
  # otherwise use hostname
  $server_name = $fqdn ? {
    undef => $hostname,
    default => $fqdn,
  }

  # Memory per apache thread, in megabytes
  $mb_per_thread = 70

  # The percentage of memory to give to Apache depends on mode.
  $percentage = $mode ? {
    'dedicated' => 0.75,
    'shared' => 0.5,
    default => 0.25,
  }

  # Parse memorysize into number and unit
  # facter 1.7 provides a memorysize_mb fact, but we still need to support older
  # versions of Puppet that do not have memorysize_mb available, at least for a
  # little while longer.
  $tokens = split($memorysize, ' ')
  $memory = $tokens[0]
  $unit = sprintf("%s", split($tokens[1], 'B'))
  
  # Determine how to convert memorysize to megabytes; unit should be G or M.
  $mb_conversion = $unit ? {
    'G' => 1024,
    'M' => 1,
    default => 0,
  }
 
  if $mb_conversion == 0 {
    fail("${memorysize} has unacceptable unit: ${unit}")
  }
  
  # Calculate MaxClients based on total physical memory
  $workers = $memory * $percentage * $mb_conversion / $mb_per_thread
  
  # Phusion Passenger has a default of 6, so we need at least 8 for minimal use
  if ($workers < 8) {
    $max_clients = 8
  } else {
    $max_clients = sprintf("%i", $workers)
  }
  
  # Install httpd.conf
  file { "${httpd_root}/conf/httpd.conf":
    ensure => present, 
    content => template("${module_name}/httpd.conf.erb"),
    notify => Service['httpd'],
  }  
}

