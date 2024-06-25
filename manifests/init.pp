# @summary RKE2, also known as RKE Government, is Rancher's next-generation
# Kubernetes distribution.
#
# @example
#   include rke2
#
# @example
#   class { 'rke2':
#     node_type => 'server',
#   }
#
# @param node_type
#
# @param release_series
#   The rke2 release series to install.  Corresponds to k8s major.minor
#   versions.  E.g. '1.28', '1.30', etc.
#
# @param server_packages
#   The list of packages to install on to a server node.
#
# @param agent_packages
#   The list of packages to install on to an agent node.
#
class rke2 (
  Enum['server','agent'] $node_type,
  String[1] $release_series,
  Array[String[1]] $server_packages,
  Array[String[1]] $agent_packages,
) {
  contain rke2::repo
  contain rke2::install
  Class['rke2::repo'] -> Class['rke2::install']
}
