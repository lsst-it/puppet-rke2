# @api private
class rke2::config {
  assert_private()

  file { '/etc/rancher/rke2/config.yaml':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => stdlib::to_yaml($rke2::config),
  }

  # The config.yaml.d directory is used by default. As we are using an all-in-one config
  # file, it should be removed to ensure no config conflicts.
  file { '/etc/rancher/rke2/config.yaml.d':
    ensure  => absent,
    recurse => true,
    force   => true,
  }
}
