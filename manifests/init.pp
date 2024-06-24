# @summary Interface class to manage rke2 installation
#
# This class is reponsible to call the install or uninstall classes
#
# @example
#   include rke2
#
# @example
#   class { 'rke2':
#     node_type         => 'server',
#     server_url        => 'https://
#     token             => 'random-string',
#     tls_san           => ['foo.example.com', 'bar.example.com'],
#     node_labels       => ['foo=bar'],
#   }
#
# @param node_type
# @param token
# @param server_url
# @param tls_san
# @param node_labels
# @param disabled_services
# @param kubelet_args
class rke2 (
  Enum['server','agent'] $node_type,
  Optional[String] $server_url = undef,
  Optional[String] $token = undef,
  Optional[Array[String]] $tls_san = undef,
  Optional[Array[String]] $node_labels = undef,
  Optional[Array[Enum['rke2-canal','rke2-coredns','rke2-ingress-nginx','rke2-metrics-server']]] $disabled_services = undef,
  Optional[Array[String]] $kubelet_args = undef,
) {
  if $node_type == 'agent' and !$server_url {
    fail('The var $server_url must be set when installing a server.')
  }

  include rke2::prepare
}
