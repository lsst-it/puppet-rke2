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
# @param release_channel
#   The rke2 release channel to use.
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
# @param config
#  Converted to the yaml as /etc/rancher/rke2/config.yaml.
#
# @param version
#   The specific version of rke2 to install and versionlock.  If not provided,
#   the latest version in the release series will be installed.
#
# @param versionlock
#   Create a yum versionlock for the installed rke2 package(s).
#
# @param manage_repo
#   When true (default), the module manages the RKE2 yum repositories.
#   Set to false to disable repo management and configure repositories
#   outside this module (e.g. via a profile or a separate Puppet module).
#
class rke2 (
  Enum['server','agent'] $node_type,
  String[1] $release_series,
  Enum['stable','latest'] $release_channel,
  Array[String[1]] $server_packages,
  Array[String[1]] $agent_packages,
  Optional[Hash] $config = undef,
  Optional[String[1]] $version = undef,
  Boolean $versionlock = false,
  Boolean $manage_repo = true,
) {
  if $manage_repo {
    contain rke2::repo
    Class['rke2::repo'] ~> Class['rke2::install']
  }

  contain rke2::install
  contain rke2::service

  if $config {
    contain rke2::config

    Class['rke2::install']
    -> Class['rke2::config']
    ~> Class['rke2::service']
  }

  Class['rke2::install']
  ~> Class['rke2::service']
}
