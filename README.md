# Introduction

**freistilbox Solo is a virtual development environment, optimized for users of our [freistilbox hosting platform](http://www.freistilbox.com).**

It is our answer to many requests by customers that want to develop and test their web applicaton in an environment that is highly similar to our production platform.

freistilbox Solo uses [Vagrant](http://www.vagrantup.com/) to launch a virtual machine based on [VirtualBox](https://www.virtualbox.org/). The setup of the virtual Linux server is completely automated with [Chef](http://www.opscode.com/chef/).


# Installation

Clone the freistilbox Solo repository to your workstation:

    $ git clone https://github.com/freistil/freistilbox-solo.git


# Requirements

## Ruby

Install a current Ruby interpreter if it is not already provided by your operating system.

All necessary Ruby gems are installed via `bundler`:

    $ gem install bundler
    $ bundle


## Virtualbox

Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).


## Vagrant

Download and install [Vagrant](http://docs.vagrantup.com/v2/installation/index.html).

To make the initial VM setup and the software provisioning runs faster, install a Vagrant plugin that caches downloaded software packages locally:

    $ vagrant plugin install vagrant-cachier


# Getting started

## Start the VM

Execute `rake up` to start the VM and the application provisioning process.

freistilbox Solo will automatically set up a development website for the application you configured in the `Vagrantfile`; the default app is "example" which contains a vanilla Drupal site.


## Choose the active application

You can use freistilbox Solo with as many applications as you like, just put each one into a separate folder below the `apps` directory. The active application is defined with the keyword `:active_app` in the `Vagrantfile`:

    chef.json = {
      :freistilbox => {
        :active_app => 'example',
        :app_config => 'drupal'
      }
    }

(So far, "drupal" is the only `app_config` value supported.)

After changing the `active_app` value, you need to update the dev environment by issuing the `rake prov` command.

Delow the application directory in `apps`, you need to create a `docroot` directory containing your web application and a file named `Boxfile` that defines certain properties of your application that freistilbox needs to know. The Boxfile format is explained in the [freistilbox documentation](http://docs.freistilbox.com/basics/boxfile/).


## Provision and access your app

After each update to your application code, run `rake prov` to have them reflected in the development environment.

You should now be able to access your development website in your browser at "http://localhost:3080".


## Shell login

To get direct shell access to the development environment, execute `rake login`.


## Shutting down the VM

Run `rake down` to shut down the virtual server. You can resurrect it at any time with `rake up`.


## Destroying the VM

To completely remove the virtual server and all its contents, use the `rake destroy` command.

CAUTION: The database is only stored within the VM and will be lost during `destroy`. (See "File storage" below.) If you need to preserve the database, be sure to make a backup and put that into the `shared_


# File storage

While Vagrant allows the virtual server access to certain direcotories on the host filesystem (aka your workstation), this shared filesystem is not fast enough to have a satisfying development experience. That's why the current state of your application is copied into the VM at each provisioning run (`rake prov`).

**When the VM is removed (aka "destroyed"), these files will be lost.**

The only exception are the directories declared as `shared_folders` in your application's `Boxfile`. These directories are connected to the shared filesystem stored on your workstation.

**You need to make sure that your workstation allows write access for these directories to the VM.**

Taking Drupal as an example:

    $ chmod a+w apps/example/docroot/sites/default/files


# Documentation and support

We're working on detailed documentation for freistilbox Solo that will be published to our [freistilbox documentation website](http://docs.freistilbox.com).

If you have a question or some feedback on using freistilbox Solo, please post it in our [freistilbox Solo community forum](https://freistil.zendesk.com/forums/22231131) on the freistil IT Help Center!


# Copyright and license

Copyright 2013, freistil IT

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
