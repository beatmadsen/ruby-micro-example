#!/usr/bin/env rackup -s thin

#\ -p 9091

require 'bundler'
Bundler.require

require './hello'

run HelloApp