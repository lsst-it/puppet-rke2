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
class rke2 (
  Enum['server','agent'] $node_type,
  String[1] $release_series,
) {
  contain rke2::repo
  contain rke2::install
  Class['rke2::repo'] -> Class['rke2::install']
}
