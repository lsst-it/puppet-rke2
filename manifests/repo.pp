# @api private
class rke2::repo {
  assert_private()

  $series = $rke2::release_series
  $major = fact('os.release.major')

  yumrepo { 'rancher-rke2-common-stable':
    descr         => 'Rancher RKE2 Common (stable)',
    baseurl       => "https://rpm.rancher.io/rke2/stable/common/centos/${major}/noarch",
    enabled       => 1,
    gpgcheck      => 1,
    repo_gpgcheck => 0,
    gpgkey        => 'https://rpm.rancher.io/public.key',
    target        => '/etc/yum.repos.d/rancher-rke2-common-stable.repo',
  }

  yumrepo { "rancher-rke2-${series}-stable":
    descr         => "Rancher RKE2 ${series} (stable)",
    baseurl       => "https://rpm.rancher.io/rke2/stable/${series}/centos/${major}/x86_64",
    enabled       => 1,
    gpgcheck      => 1,
    repo_gpgcheck => 0,
    gpgkey        => 'https://rpm.rancher.io/public.key',
    target        => "/etc/yum.repos.d/rancher-rke2-${series}-stable.repo",
  }
}
