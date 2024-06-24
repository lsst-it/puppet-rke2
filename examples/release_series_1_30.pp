resources { 'yumrepo':
  purge => true,
}

class { 'rke2':
  release_series => '1.30',
}
