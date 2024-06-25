class { 'yum':
  manage_os_default_repos => true,
}

resources { 'yumrepo':
  purge => true,
}

class { 'rke2':
  release_series => '1.30',
  version        => '1.30.0~rke2r1',
  versionlock    => true,
  config         => {
    tls-san                  => [
      'rke2.example.com',
    ],
    node-label               => [
      'role=storage-node',
    ],
    disable                  => [
      'rke2-ingress-nginx',
    ],
    disable-cloud-controller => true,
  },
}
