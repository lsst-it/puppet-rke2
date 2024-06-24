# rke2

Welcome to rke2 module. This module installs the Rancher's lightweight
Kubernetes, rke2 (see more on https://rke2.io/).

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with rke2](#setup)
   - [Beginning with rke2](#beginning-with-rke2)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs the open source Rancher's next-generation Kubernetes, rke2.

Using this module, you can easily automate rke2 installation in many machines,
like in a School Lab.

## Setup

### Beginning with rke2

Install this module using Puppet: `puppet module install etma/rke2`

Or via Puppetfile: `mod 'etma-rke2', '1.0.0'`

## Usage

- Quick run: `puppet apply -e "include rke2"`

- Installing using the script installation mode:

```puppet
class { 'rke2':
  installation_mode => 'script',
}
```

- Installing using the binary installation mode:

```puppet
class { 'rke2':
  installation_mode => 'binary',
}
```

- Ensuring that it is uninstalled:

```puppet
class { 'rke2':
  ensure            => 'absent',
  installation_mode => 'script',
}
```

## Development

### Contributing

- Create a topic branch from where you want to base your work. This is usually the master branch.
- Push your changes to a topic branch in your fork of the repository.
- Add yourself as a contributor in the Contributors sections of this file.
- Make sure your commits messages are describing what has changed.
- Make sure you have tested your changes and nothing breaks.
- Validate your module using `pdk validate`.
- Submit a pull request to this repository.

## Release Notes/Contributors/Etc

- Author: Erik Andersen (etma@vertisky.com)
- Based on the k3s script from Igor Oliveira (igor.bezerra96@gmail.com) (igorolivei/puppet-k3s)
