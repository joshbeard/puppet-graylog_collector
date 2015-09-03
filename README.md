# puppet-graylog_collector

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with graylog_collector](#setup)
    * [What graylog_collector affects](#what-graylog_collector-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with graylog_collector](#beginning-with-graylog_collector)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Authors](#authors)

## Overview

This module is still in initial development, as well as the README!

Puppet module to manage [Graylog Collector](http://docs.graylog.org/en/1.2/pages/collector.html)

## Module Description

Manages the installation and configuration of Graylog Collector, including
configuring inputs and outputs.

## Setup

### What graylog_collector affects

* Installs the Graylog Collector from archive bundle (package installation
  coming soon).
* Optionally manages the user/group to run as
* Provides an init script and optionally manages the service
* Manages the Graylog Collector configuration file

### Setup Requirements

Requires an installation of Java, which is not managed by this module.

Try [puppetlabs-java](https://forge.puppetlabs.com/puppetlabs/java)

### Beginning with graylog_collector

1. Declare the base class and provide a server url to connect to.
2. Declare any inputs/outputs you'd like to manage.

## Usage

### Class: `graylog_collector`

The base class "entry point" for the module.

### Defined Type: `graylog_collector::input`

Manages input configurations

### Defined Type: `graylog_collector::output`

Manages output configurations

### Private Class: `graylog_collector::install::archive`

Manages installing Graylog Collector from archives

### Private Class: `graylog_collector::config`

Manages the configuration for Graylog Collector

### Private Class: `graylog_collector::service`

Manages the Graylog Collector service

## Reference

### Class: `graylog_collector`

TODO

### Defined Type: `graylog_collector::input`

TODO

### Defined Type: `graylog_collector::output`

TODO

## Limitations

This has only been tested on EL6.

## Development

### TODO

* Manage package installation.  Graylog provides packages for some platforms,
  but not EL6 yet.  See https://github.com/Graylog2/fpm-recipes/issues/42
  Also track https://github.com/Graylog2/fpm-recipes

* Ensure service is robust in situations where it cannot reach the server.

* Improve parameter validation

* Add additional operating system support (EL7, Windows, Systemd service)

Contributions are more than welcome!

1. Fork this repo
2. Do your work
3. Create a pull request

## Authors

Josh Beard (<josh@signalboxes.net>)
