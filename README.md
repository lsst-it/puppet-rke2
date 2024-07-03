# rke2

## Table of Contents

1. [Overview](#overview)
1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Overview

[RKE2](https://docs.rke2.io/), also known as RKE Government, is Rancher's next-generation Kubernetes distribution.

## Description

This module installs `rke2` from packages (E.g. a yum repo) and configures the installation via `config.yaml`.

> [!IMPORTANT]
> The `rspec-beaker` tests timeout / fail under github actions and at not part of an active workflow.  The acceptance tests will need to be run manually prior to the merge of PRs.

## Usage

Example role defined via hiera.

```yaml
---
lookup_options:
  rke2::config:
    merge:
      strategy: "deep"
      knockout_prefix: "--"
classes:
  - "rke2"
rke2::config:
  server: "https://%{::cluster}.%{::site}.example.com:9345"
  token: "ENC[PKCS7,...]"
  node-name: "%{facts.hostname}"
  tls-san:
    - "%{::cluster}.%{::site}.example.com"
  node-label:
    - "role=storage-node"
  disable:
    - "rke2-ingress-nginx"
  disable-cloud-controller: true
```

In this example, a DNS A/AAAA record for `%{::cluster}.%{::site}.example.com` is required.

If the cluster is being provisioned from scratch.
In other words, when there are no pre-existing etcd instances.
The `server` key will need to be manually deleted from `/etc/rancher/rke2/config.yaml` on one (and only one) node and the `rke2-server` service restarted.
While this key could be knocked on a single node via hiera, if the node without the `server` key is ever re-provisioned, it would create a new standalone cluster instance which is detached from the existing etcd instances.

## Reference

See [REFERENCE](REFERENCE.md)
