# @summary Class responsible for uninstalling rke2
class rke2::uninstall {
  case $rke2::installation_mode {
    'script': {
      exec { '/usr/local/bin/rke2-uninstall.sh':
        onlyif => '/usr/bin/test -f /usr/local/bin/rke2-uninstall.sh',
      }
    }

    'binary': {
      file { $rke2::binary_path:
        ensure => absent,
      }
    }

    default: {
      notify { 'No valid installation mode provided.': }
    }
  }
}
