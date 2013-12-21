# The vagrant class defines some tweaks we need to set up our test VMs
class vagrant {
  # We don't need iptables running in our VM's.
  service { 'iptables':
    ensure => stopped,
  }
}
