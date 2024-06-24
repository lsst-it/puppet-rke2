# @summary Interface class to manage rke2 installation
#
# This class is reponsible to call the install or uninstall classes
#
# @example
#   include rke2
#
# @example
#   class { 'rke2':
#     ensure            => 'present',
#     installation_mode => 'binary',
#     node_type         => 'server',
#     max_pods          => 200,
#     server_url        => 'https://
#     token             => 'random-string',
#     arguments         => '--disable=servicelb --disable=traefik --disable=coredns',
#     tls_san           => ['foo.example.com', 'bar.example.com'],
#     node_labels       => ['foo=bar'],
#     binary_version    => 'v1.25.14+rke2r1',
#     binary_path       => '/home/john-doe/bin/rke2',
#   }
class rke2 (
  Enum['present', 'absent'] $ensure,
  Enum['script', 'binary'] $installation_mode,
  Enum['server','agent'] $node_type,
  Int $max_pods,
  String $server_url,
  String $token,
  String $arguments,
  Array[String] $tls_san,
  Array[String] $node_labels,
  Array[Enum['rke2-canal','rke2-coredns','rke2-ingress-nginx','rke2-metrics-server']] $disabled_services,
  String $binary_version,
  String $binary_path,
) {
  if $installation_mode == 'binary' and (!$binary_path or !$binary_version) {
    fail('The vars $binary_version and $binary_path must be set when using the binary installation mode.')
  }
  if !$token {
    fail('The var $token must be set.')
  }
  if !$node_type {
    fail('The var $node_type must be set to either master or agent.')
  }
  if $node_type == 'agent' and !$server_url {
    fail('The var $server_url must be set when installing a server.')
  }
  if !$tls_san {
    fail('The var $tls_san must be set when installing a server.')
  }

  if $ensure == 'present' {
    include rke2::prepare
    include rke2::install
  } else {
    include rke2::uninstall
  }
}
