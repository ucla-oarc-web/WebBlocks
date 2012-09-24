#
# WebBlocks Build Script
# 
# This script performs a WebBlocks build taskas:
# 
#   rake [command]
# 
# One may specify a configuration file besides /Rakefile-config.rb via a
# command-line argument passed to rake:
# 
#   rake [command] -- --config=Rakefile-config.rb
#   
# This Rakefile uses a number of libraries within the WebBlocks namespace that 
# reside within the /rake directory.
#

# Confirm that all requisites have been installed
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

# Load required libraries
require 'rake'
require 'pathname'
require 'fileutils'
require 'optparse'
include Rake::DSL

# Parse the --config option if specified
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: rake [options]"
  options[:config] = false
  opts.on( '-c', '--config [OPT]', "Config file location (optional)" ) do |filename|
    options[:config] = filename || false
  end
end.parse!

# Load the required WebBlocks rake libraries
load 'rake/builder.rb'
load 'rake/config.rb'

# Load the configuration file, either Rakefile-config.rb or as specified by
# the command-line argument --config
load options[:config] ? options[:config] : 'Rakefile-config.rb'

builder = WebBlocks::Builder.new(WebBlocks.config)

# By default, invoke the build task
task :default   => [:build]

# The init task initializes WebBlocks unless it is already initialized
task :init do
  invoke builder.blocks, :init unless builder.blocks.init?
end

# The build task sets up a temporary region for the build process, then builds 
# all packages into the region, followed by WebBlocks itself, and finally 
# replaces the existing build directory with the newyl built version and cleans
# up the temporary region. If any step in the build process fails, it will still
# clean up build remenants.
task :build     => [:init] do
  begin
    invoke builder.blocks, :build_setup
    invoke builder.packages, :build
    invoke builder.blocks, :build
  ensure
    invoke builder.blocks, :build_cleanup
  end
end

# The build_all task is essentially the same as the build task, except that it
# recompiles all packages that require a compile.
task :build_all => [:init] do
  begin
    invoke builder.blocks, :build_setup
    invoke builder.packages, :compile
    invoke builder.packages, :build
    invoke builder.blocks, :build
  ensure
    invoke builder.blocks, :build_cleanup
  end
end

# The clean task removes the WebBlocks build.
task :clean => [:init] do
  invoke builder.blocks, :clean
end

# The clean_packages task removes any compilations that occurred as part of 
# the package build processes.
task :clean_packages => [:init] do
  invoke builder.packages, :clean
end

# The clean_all task both removes the WebBlocks build and any compilations of
# packages that occurred.
task :clean_all => [:clean_packages, :clean]

task :reset => [:clean_all, :reset_packages] do
  invoke builder.blocks, :reset
end

# The reset_packages task resets all Git submodules by removing them. If using
# this task, you will need to refetch all Git submodules before a WebBlocks
# build may occur. Implicitly, this process will also clean all packages.
task :reset_packages => [:clean_packages] do
  invoke builder.packages, :reset
end

# TODO: The check task WILL check if the environment is configured properly.
task :check do
  # TODO
end

# The environment task provides output about the paths, packages and includes
# for the WebBlocks build as currently configured.
task :environment => [:paths, :packages, :includes]

# TODO: The packages task determines all packages that will be included in the
# WebBlocks build as currently configured.
task :packages do
end

# TODO: The includes task determines all modules that will be included in the
# WebBlocks build as currently configured.
task :includes do
end

# TODO: The paths task determines the paths that will be used as part of the
# WebBlocks build (including sources, packages, includes and destinations)
# as currently configured.
task :paths do
end

# Helper function that accepts an object or array of objects and invokes a 
# method on each of them, if they respond to the method. This is useful in
# this context because not all builders will necessarily respond to a given
# method.
def invoke object, method
  if object.respond_to? :each
    object.each { |obj| invoke obj, method }
  elsif object.respond_to? method
    object.send(method)
  end
end
