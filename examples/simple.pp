class { 'yum':
  manage_os_default_repos => true,
}

resources { 'yumrepo':
  purge => true,
}

include rke2
