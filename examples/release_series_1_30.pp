class { 'yum':
  manage_os_default_repos => true,
}

resources { 'yumrepo':
  purge => true,
}

class { 'rke2':
  release_series => '1.30',
}
