#!/usr/bin/env bash

gem list | grep -q chef || sudo /opt/vagrant_ruby/bin/gem install chef --version 11.4.2 --no-rdoc --no-ri
