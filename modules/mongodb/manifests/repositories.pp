# Yum repositories required to install MongoDB
class mongodb::repositories {
  yumrepo { '10gen':
    baseurl => 'http://downloads-distro.mongodb.org/repo/redhat/os/x86_64',
    descr => '10gen Repository',
    enabled => 1,
    gpgcheck => 0,
  }
}

