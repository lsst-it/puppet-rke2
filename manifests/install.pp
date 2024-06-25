# @api private
class rke2::install {
  assert_private()

  if $rke2::node_type == 'server' {
    $pkgs = $rke2::server_packages
  } else {
    $pkgs = $rke2::agent_packages
  }

  package { $pkgs:
    ensure => installed,
  }
}
