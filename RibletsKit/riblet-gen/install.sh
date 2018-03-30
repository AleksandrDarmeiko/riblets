#!/usr/bin/env ruby
require 'fileutils'

dir_to_instal  = '/usr/local/bin/'

file_to_install = "#{File.dirname __FILE__}"
FileUtils.copy_entry(file_to_install, dir_to_instal)
