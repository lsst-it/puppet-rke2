# @summary Class responsible for installing rke2
#
# @api private
class rke2::install {
  assert_private()

  case $rke2::installation_mode {
    'script': {
      archive { '/tmp/rke2_install.sh':
        ensure           => present,
        filename         => '/tmp/rke2_install.sh',
        source           => 'https://get.rke2.io',
        creates          => '/tmp/rke2_install.sh',
        download_options => ['-s'],
        cleanup          => false,
      }

      file { '/tmp/rke2_install.sh':
        ensure  => file,
        mode    => '0744',
        require => [
          Archive['/tmp/rke2_install.sh'],
        ],
      }

      exec { '/tmp/rke2_install.sh':
        require     => [
          File['/etc/rancher/rke2/config.yaml.d/00-config.yaml'],
        ],
        subscribe   => [
          Archive['/tmp/rke2_install.sh'],
        ],
        refreshonly => true,
      }

      service { 'rke2':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => [
          Exec['/tmp/rke2_install.sh'],
          File['/etc/rancher/rke2/config.yaml.d/00-config.yaml'],
        ],
      }
    }

    'binary': {
      case $facts['os']['architecture'] {
        'amd64', 'x86_64': {
          $binary_arch = 'rke2'
          $checksum_arch = 'sha256sum-amd64.txt'
        }
        'arm64': {
          $binary_arch = 'rke2-arm64'
          $checksum_arch = 'sha256sum-arm64.txt'
        }
        'armhf': {
          $binary_arch = 'rke2-armhf'
          $checksum_arch = 'sha256sum-arm.txt'
        }
        default: {
          fail('No valid architecture provided.')
        }
      }
      $rke2_url = "https://github.com/rancher/rke2/releases/download/${rke2::binary_version}/rke2.linux-${binary_arch}"
      $rke2_checksum_url = "https://github.com/rancher/rke2/releases/download/${rke2::binary_version}/${checksum_arch}"

      archive { $rke2::binary_path:
        ensure           => present,
        source           => $rke2_url,
        checksum_url     => $rke2_checksum_url,
        checksum_type    => 'sha256',
        cleanup          => false,
        creates          => $rke2::binary_path,
        download_options => '-S',
        require          => [
          File['/etc/rancher/rke2/config.yaml.d/00-config.yaml'],
        ],
      }

      file { $rke2::binary_path:
        ensure  => file,
        mode    => '0755',
        require => [
          Archive[$rke2::binary_path],
        ],
      }
    }

    default: {
      fail('No valid installation mode provided.')
    }
  }
}
