#!/usr/bin/env ruby
require 'fileutils'
dir_to_instal  = '/usr/local/bin/'
file_to_install = "#{File.dirname __FILE__}/viewable-riblet-gen"
FileUtils.cp(file_to_install, dir_to_instal)
file_to_install = "#{File.dirname __FILE__}/riblet-gen"
FileUtils.cp(file_to_install, dir_to_instal)
file_to_install = "#{File.dirname __FILE__}/riblet-gen-lib.rb"
FileUtils.cp(file_to_install, dir_to_instal)
