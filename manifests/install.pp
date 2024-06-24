# @api private
class rke2::install {
  assert_private()

  if $rke2::node_type == 'server' {
    $package_name = 'rke2-server'
  } else {
    $package_name = 'rke2-agent'
  }

  package { $package_name:
    ensure => installed,
  }
}
