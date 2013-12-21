# wget wrapper
# Parameters:
#   $url:  URL to download
#   $file: The downloaded file. It will be placed in $cwd, no need for path.
#   $cwd:  working directory for the command; defaults to /var/tmp
#
define utils::wget($url, $file, $cwd = '/var/tmp') {
  exec { "download_${title}":
    path => '/bin:/usr/bin',
    cwd => $cwd,
    command => "wget -c ${url}",
    creates => "${cwd}/${file}",
    timeout => 0,
    require => Package['wget'],
  }
}
