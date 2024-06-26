class { 'rke2':
  release_series => '1.28',
  version        => '1.28.2~rke2r1',
  config         => {
    snapshotter => 'native',
  },
}
