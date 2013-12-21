# Defines the EPEL yum repository for package installation
class epel {
  yumrepo { 'epel':
    baseurl => "http://download.fedoraproject.org/pub/epel/6/\$basearch",
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch',
    descr => "EPEL Repo",
    enabled => 1,
    gpgcheck => 0,
  }
}

