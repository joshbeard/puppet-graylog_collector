# puppet-graylog_collector

[![Puppet Forge](http://img.shields.io/puppetforge/v/joshbeard/graylog_collector.svg)](https://forge.puppetlabs.com/joshbeard/graylog_collector)
[![Build Status](https://travis-ci.org/joshbeard/puppet-graylog_collector.svg?branch=master)](https://travis-ci.org/joshbeard/puppet-graylog_collector)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with graylog_collector](#setup)
    * [What graylog_collector affects](#what-graylog_collector-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with graylog_collector](#beginning-with-graylog_collector)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference](#reference)
    * [Class: graylog_collector](#class-graylog_collector)
    * [Defined Type: graylog_collector::input](#class-graylog_collector__input)
    * [Defined Type: graylog_collector::output](#class-graylog_collector__output)
6. [Examples](#examples)
7. [Limitations - OS compatibility, etc.](#limitations)
8. [Development - Guide for contributing to the module](#development)
9. [Authors](#authors)

## Overview

This module is still in initial development, as well as the README!

Puppet module to manage [Graylog Collector](http://docs.graylog.org/en/1.2/pages/collector.html)

You should refer to the [Graylog Collector Documentation](http://docs.graylog.org/en/latest/pages/collector.html)
at [http://docs.graylog.org/en/latest/pages/collector.html](http://docs.graylog.org/en/latest/pages/collector.html)
to aide you in the use of this module.  Most parameters map to the configuration
options.

## Module Description

Manages the installation and configuration of Graylog Collector, including
configuring inputs and outputs.

## Setup

### What graylog_collector affects

* Installs the Graylog Collector via archive or package
* Optionally manages package managment repos
* Optionally manages the user/group to run as
* Optionally provides an init script and optionally manages the service
* Manages the Graylog Collector configuration file

### Setup Requirements

Requires an installation of Java, which is not managed by this module.

Try [puppetlabs-java](https://forge.puppetlabs.com/puppetlabs/java)

If using Ubuntu or Debian and managing the graylog-collector repo with this
module, you'll need [puppetlabs-apt](https://forge.puppetlabs.com/puppetlabs/apt)

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

Refer to [http://docs.graylog.org/en/latest/pages/collector.html#global-settings](http://docs.graylog.org/en/latest/pages/collector.html#global-settings)

#### Parameters

__server_url__

Required. Specifies the URL (including port) for the Graylog2 server.

__enable_registration__

Boolean. Default: true

__collector_id__

Default: 'file:/etc/graylog/collector/config/collector-id'

__install_path__

Default: '/usr/share'

Specifies the path to install Graylog Collector to.

Note: If installing via _archive_, this will append the version to the
directory, as it's extracted from the tarball.  A symlink will be created
called "graylog-collector" that links to it.

__config_dir__

Default: '/etc/graylog/collector'

The directory for the Graylog Collector configuration file.

__sysconfig_dir__

Default: '/etc/default' or '/etc/sysconfig', depending on OS.

The sysconfig path.  This is typically `/etc/default` or `/etc/sysconfig`

__java_cmd__

Default: '/usr/bin/java'

The absolute path to the `java` executable to use for running the Graylog
Collector.

__java_opts__

Default: undef

Any additional Java options to pass when running Graylog Collector.

__user__

Default: 'root'

The user to run Graylog Collector as.  Keep in mind that the collector needs
access to whatever files you feed to it.

__group__

Default: 'root'

The group for the collector.  This is used for ownership of the config files.

__manage_user__

Default: false

Specifies whether this module should manage the user.  If you're running as
root, you probably shouldn't let this module manage the user.

__manage_group__

Default: false

Specifies whether this module should manage the group.  If you're running as
root, you probably shouldn't let this module manage the group.

__manage_init__

Default: undef

Specifies whether this module should manage the init script or init config
file.

If `install_from` is set to _package_, this `manage_init` defaults to __false__

If installing from archive, it defaults to __true__

__manage_service__

Default: true

Specifies whether this module should manage the service.

__service_ensure__

Default: 'running'

State of the service.

__service_enable__

Default: true

Enable the service on boot or not.

__service_name__

Default: 'graylog-collector'

The name of the service to manage if `manage_service` is true.

__install_from__

Default: _depends on platform_

Possible values are _package_ and _archive_

Defaults to _package_ for:

* Ubuntu 12x
* Ubuntu 14x
* Debian 8
* EL 7

Defaults to _archive_ for everything else.

Refer to the [Graylog Collector documentation](http://docs.graylog.org/en/1.2/pages/collector.html)
for information about package repositories.

__version__

Default: _depends on installation method_

For archive, it defaults to `0.4.1`.  For package, it defaults to _installed_

The version of Graylog Collector to install.

__source_url__

Default: 'https://packages.graylog2.org/releases/graylog-collector/graylog-collector-0.4.0.tgz'

This is not relevant if `install_from` is set to _package_

URL to download the tarball from for installation when `install_from` is
set to 'archive'

__service_file__

Absolute path to the location of the init script or service definition.

__service_template__

Optional custom template to use for the service file/init script.

__manage_repo__

Whether this module should manage the package repositories.  This is only
relevant if installing via package.

### Defined Type: `graylog_collector::input`

Refer to [http://docs.graylog.org/en/latest/pages/collector.html#input-settings](http://docs.graylog.org/en/latest/pages/collector.html#input-settings)
and [http://docs.graylog.org/en/latest/pages/collector.html#input-output-routing](http://docs.graylog.org/en/latest/pages/collector.html#input-output-routing)

__input_name__

Default: $title

The name of the input to manage

__path__

Default: undef

If collecting an absolute path, this should refer to it.

__type__

Default: 'file'

__path_glob_root__

Default: undef

If you're collecting a file glob (e.g. *.log), this should refer to the base
directory that contains that glob.

Example: '/usr/share/tomcat/logs'

__path_glob_pattern__

Default: undef

The glob pattern used for collection.

Example: '*.log' or '*.{err,log}'

__content_splitter__

Default: 'NEWLINE'

How to split the content.  Basically - how to separate messages.  Valid options
are 'NEWLINE' or 'PATTERN'

__content_splitter_pattern__

Default: undef

If splitting on 'PATTERN', what regex should be used to separate log messages.

Note that regex escapes must be escaped.  So a normal regex pattern of `\d`
should be `\\d`

__charset__

Default: 'UTF-8'

__reader_interval__

Default: '100ms'

__global_message_fields__

Hash.

Default: {}

Message fields allow for you to add your own fields to a log message. For
example, appending the application name or some other metadata.  The
'global' message fields parameter is intended for situations where you'd like
to apply a global set of fields to all inputs, but allow for
application-specific fields to be added.  Since these are hashes, you would
normally need a wrapper or some other trickery to combine a global set of
fields with application-specific fields, or declare your global fields with
every declaration of an input.  This is useful, for example, when you'd like
to set message fields with something like Hiera or in a base profile.

The global message fields will be merged with the 'message_fields' parameter.

Example:

```puppet
global_message_fields {
  'fqdn'            => $::fqdn,
  'org_environment' => $::org_environment,
}
```

__message_fields__

Hash.

Default: {}

Refer to 'global_message_fields' above.  These are fields _in addition to_
the 'global_message_fields'.  These take precedence, however.

```puppet
global_message_fields {
  'application_name' => 'tomcat',
  'app'              => 'pluto',
  'logfile'          => 'catalina.out',
}
```

__outputs__

Default: undef

Array.

The outputs to send this input to.  See `graylog::collector::output`  You can
specify an output on the input or an input on the output (whoa).

### Defined Type: `graylog_collector::output`

Refer to [http://docs.graylog.org/en/latest/pages/collector.html#output-settings](http://docs.graylog.org/en/latest/pages/collector.html#output-settings)
and [http://docs.graylog.org/en/latest/pages/collector.html#input-output-routing](http://docs.graylog.org/en/latest/pages/collector.html#input-output-routing)

__output_name__

Default: title

The name of the output to configure. Example: 'gelf'

__type__

Default: gelf

The type of output. Valid options are 'gelf' and 'stdout'

__host__

Default: undef

If type is 'gelf', this refers to the host to send logs to. The Graylog2
server should have a GELF TCP input configured and listening.

__port__

Default: undef

If type is 'gelf', this refers to the port to send logs to. The Graylog2
server should have a GELF TCP input configured and listening.

__client_tls__

Boolean.

Default: false

Specifies whether to use TLS to connect when the output is 'gelf'

__client_tls_cert_chain_file__

Default: undef

__client_tls_verify_cert__

Boolean.

Default: true

__client_queue_size__

Default: '512'

__client_connect_timeout__

Default: '5000'

__client_reconnect_delay__

Default: '1000'

__client_tcp_no_delay__

Boolean.

Default: true

__client_send_buffer_size__

Default: '-1'

__inputs__

Array.

Default: undef

Works like 'outputs' with `graylog_collector::input`.  What _inputs_ should
be sent to this output.  You can leave this empty and specify them with the
_input_ if you'd like.

## Examples

Example of declaring the common configuration in a base profile:

```puppet
class profile::base::graylog {
  class { '::graylog_collector':
    server_url => '8.8.8.8:12900',
  }

  graylog_collector::output { 'gelf':
    type => 'gelf',
    host => '8.8.8.8',
    port => '12900',
  }
}
```

Example of managing an 'input' for a specific application:

```puppet
class profile::apps::pluto {
  graylog_collector::input { 'pluto_catalina_out':
    path                     => "${catalina_base}/logs/catalina.out",
    content_splitter         => 'PATTERN',
    content_splitter_pattern => '^(\\d{4}-\\d{2}-\\d{2}|\\d{2}-\\w{3}-\\d{4})\\s\\d{1,2}:\\d{1,2}:\\d{1,2}',
    message_fields           => {
      'application_name' => 'tomcat',
      'app'              => 'pluto',
      'logfile'          => 'catalina.out',
    }
  }
}
```

Example of a file glob:

```puppet
class profile::apps::pluto {
  graylog_collector::input { 'pluto_tomcat_logs':
    path_glob_root           => "${catalina_base}/logs",
    path_glob_pattern        => "*.{out,log,txt}",
    content_splitter         => 'PATTERN',
    content_splitter_pattern => '^(\\d{4}-\\d{2}-\\d{2}|\\d{2}-\\w{3}-\\d{4})\\s\\d{1,2}:\\d{1,2}:\\d{1,2}',
    message_fields           => {
      'application_name' => 'tomcat',
      'app'              => 'pluto',
    }
  }
}
```

An example of using a _collector_ to add 'global_message_fields' to all inputs:

```puppet
Graylog_collector::Input <| |> {
  outputs               => [ 'gelf' ],
  global_message_fields => {
    'fqdn'            => $::fqdn,
    'org_environment' => $::org_environment,
  }
}
```


## Limitations

Tested on:

* CentOS 6
* CentOS 7
* Ubuntu 14.04

## Development

### TODO

* Extend package installation.  Waiting on upstream for EL6.
  https://github.com/Graylog2/fpm-recipes/issues/42
  Also track https://github.com/Graylog2/fpm-recipes

* Add additional operating system support

* Add testing

* Cleanups, especially around installation and service management

### Contributing

Contributions are more than welcome!  Reporting issues or code contributions.

1. Fork this repo
2. Do your work
3. Create a pull request

## Authors

Josh Beard (<josh@signalboxes.net>)
