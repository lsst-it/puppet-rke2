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
#     tls_san           => ['foo.example.com', 'bar.example.com'],
#     node_labels       => ['foo=bar'],
#     binary_version    => 'v1.25.14+rke2r1',
#     binary_path       => '/home/john-doe/bin/rke2',
#   }
#
# @param ensure
# @param installation_mode
# @param node_type
# @param max_pods
# @param binary_version
# @param binary_path
# @param token
# @param server_url
# @param tls_san
# @param node_labels
# @param disabled_services
class rke2 (
  Enum['present', 'absent'] $ensure,
  Enum['script', 'binary'] $installation_mode,
  Enum['server','agent'] $node_type,
  Integer $max_pods,
  String $binary_version,
  String $binary_path,
  Optional[String] $token = undef,
  Optional[String] $server_url = undef,
  Optional[Array[String]] $tls_san = undef,
  Optional[Array[String]] $node_labels = undef,
  Optional[Array[Enum['rke2-canal','rke2-coredns','rke2-ingress-nginx','rke2-metrics-server']]] $disabled_services = undef,
) {
  if $installation_mode == 'binary' and (!$binary_path or !$binary_version) {
    fail('The vars $binary_version and $binary_path must be set when using the binary installation mode.')
  }
  if !$node_type {
    fail('The var $node_type must be set to either master or agent.')
  }
  if $node_type == 'agent' and !$server_url {
    fail('The var $server_url must be set when installing a server.')
  }

  if $ensure == 'present' {
    include rke2::prepare
    include rke2::install
  } else {
    include rke2::uninstall
  }
}
