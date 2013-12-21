# Installs the enhanced version of vim that includes syntax highlighting and
class vim {
  package { 'vim-enhanced': 
    ensure => installed,
  }
}

