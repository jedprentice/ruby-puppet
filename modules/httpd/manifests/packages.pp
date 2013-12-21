# Installs httpd AKA Apache
#
# mod_security is available in EPEL and provides a few extra directives that
# allow for better obfuscation of server metadata that would otherwise be 
# visible in the HTTP headers. mod_security provides the SecServerSignature
# directive, among others.
class httpd::packages {
  package { 'httpd':
    ensure => installed,
  }
}

