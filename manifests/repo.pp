# @api private
class rke2::repo {
  assert_private()

  $series = $rke2::release_series
  $channel = $rke2::release_channel
  $major = fact('os.release.major')

  yumrepo { "rancher-rke2-common-${channel}":
    descr         => "Rancher RKE2 Common (${channel})",
    baseurl       => "https://rpm.rancher.io/rke2/${channel}/common/centos/${major}/noarch",
    enabled       => 1,
    gpgcheck      => 1,
    repo_gpgcheck => 0,
    gpgkey        => 'https://rpm.rancher.io/public.key',
    target        => "/etc/yum.repos.d/rancher-rke2-common-${channel}.repo",
  }

  yumrepo { "rancher-rke2-${series}-${channel}":
    descr         => "Rancher RKE2 ${series} (${channel})",
    baseurl       => "https://rpm.rancher.io/rke2/${channel}/${series}/centos/${major}/x86_64",
    enabled       => 1,
    gpgcheck      => 1,
    repo_gpgcheck => 0,
    gpgkey        => 'https://rpm.rancher.io/public.key',
    target        => "/etc/yum.repos.d/rancher-rke2-${series}-${channel}.repo",
  }
}
