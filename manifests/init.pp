# @summary Interface class to manage rke2 installation
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
