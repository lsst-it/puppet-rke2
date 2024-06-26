class { 'rke2':
  release_series => '1.30',
  config         => {
    snapshotter => 'native',
  },
}
