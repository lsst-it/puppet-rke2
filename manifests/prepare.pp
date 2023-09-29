# @summary Class responsible for preparing rke2
class rke2::prepare {
  # create the config file /etc/rancher/rke2/config.yaml.d/00-config.yaml
  file { '/etc/rancher/rke2/config.yaml.d/00-config.yaml':
    ensure  => file,
    mode    => '0644',
    content => template('rke2/config.yaml.erb'),
    require => [
      File['/tmp/rke2_install.sh'],
    ],
  }
}
