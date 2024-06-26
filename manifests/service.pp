# @api private
class rke2::service {
  assert_private()

  if $rke2::node_type == 'server' {
    $svc = 'rke2-server'
  } else {
    $svc = 'rke2-agent'
  }

  service { $svc:
    ensure => 'running',
    enable => true,
  }
}
