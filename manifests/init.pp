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
class rke2 (
  Enum['server','agent'] $node_type,
) {
}
