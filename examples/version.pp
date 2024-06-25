class { 'yum':
  manage_os_default_repos => true,
}

resources { 'yumrepo':
  purge => true,
}

class { 'rke2':
  release_series => '1.28',
  version        => '1.28.2~rke2r1',
}
