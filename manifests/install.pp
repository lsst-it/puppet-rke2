# @api private
class rke2::install {
  assert_private()

  if $rke2::versionlock and $rke2::version == undef {
    fail('rke2::version must be set when rke2::versionlock is true')
  }

  if $rke2::node_type == 'server' {
    $pkgs = $rke2::server_packages
  } else {
    $pkgs = $rke2::agent_packages
  }

  $v = $rke2::version ? {
    undef => installed,
    default => $rke2::version,
  }

  package { $pkgs:
    ensure => $v,
  }

  if $rke2::versionlock {
    $pkgs.each |$pkg| {
      yum::versionlock { $pkg:
        ensure  => present,
        version => $rke2::version,
        before  => Package[$pkg],
      }
    }
  }
}
