require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'pathname'
require 'fileutils'
require 'optparse'
include Rake::DSL

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: rake [options]"
  options[:config] = false
  opts.on( '-c', '--config [OPT]', "Config file location (optional)" ) do |filename|
    options[:config] = filename || false
  end
  
end.parse!

load 'rake/builder.rb'
load 'rake/config.rb'
load options[:config] ? options[:config] : 'Rakefile-config.rb'

builder = WebBlocks::Builder.new(WebBlocks.config)

#
# primary tasks
#

task :default   => [:build]

task :build     => [:clean, :init, :_build_execute, :_build_cleanup]

task :build_all => [:clean_all, :packages_update, :build]

task :clean     => [:_build_cleanup] do
  builder.rm_build_dir
end

task :clean_all => [:packages_clean, :clean]

task :check do
  puts "WARNING: this does not necessarily work with non-default CMD paths"
  WebBlocks.config[:exec].each do |cmd|
    fail "git [#{cmd}] must be installed" unless executable_exists(cmd)
  end
  puts "prerequisite check successful"
end

task :init do
  unless builder.init?
    Rake::Task["packages_update"].invoke
    builder.init
  end
end

task :reset => [:clean_all] do
  builder.reset
end

#
# build subtasks
#

task :_build_setup do
  builder.mk_tmp_build_dir
  builder.touch_tmp_build_files
end

task :_build_execute => [
  :_build_setup,
  :_build_compass,
  builder.package?(:jquery) ? :_build_package_jquery : :_skip,
  builder.package?(:bootstrap) ? :_build_package_bootstrap : :_skip,
  builder.package?(:modernizr) ? :_build_package_modernizr : :_skip,
  builder.package?(:respond) ? :_build_package_respond : :_skip,
  builder.package?(:selectivizr) ? :_build_package_selectivizr : :_skip
] do
  
  builder.mk_build_dir
  builder.generate_build_files
  
end

task :_build_cleanup do
  builder.rm_tmp_build_dir
end

task :_skip do
  next
end

#
# build package subtasks
# 

task :_build_package_jquery => [:_build_setup, :package_jquery_build] do
  builder.append_jquery_js
end

task :_build_compass => [:_build_setup] do
  builder.append_sass
end

task :_build_package_bootstrap => [:_build_setup] do
  builder.append_bootstrap_js
  builder.copy_bootstrap_images
end

task :_build_package_modernizr => [:_build_setup] do
  builder.append_modernizr_js
end

task :_build_package_respond => [:_build_setup] do
  builder.append_respond_js
end

task :_build_package_selectivizr => [:_build_setup] do
  builder.append_selectivizr_js
end

#
# package tasks
# 

task :packages_build => [:packages_update, :package_jquery_build]

task :packages_clean => [:package_jquery_clean]

task :packages_update => [:packages_clean, :package_update, :package_jquery_update]

task :package_update do
  builder.update_packages
end

task :package_jquery_build do
  unless WebBlocks::Builder::JQuery.new(WebBlocks.config).build
    puts "Skipping package_build_jquery as build already exists"
  end
end

task :package_jquery_clean do
  WebBlocks::Builder::JQuery.new(WebBlocks.config).clean
end

task :package_jquery_update do
  WebBlocks::Builder::JQuery.new(WebBlocks.config).update
end

#
# helper functions
#

def executable_exists(name)
  if system("which #{name}") == nil and system("where #{name}") == false
    return false
  else
    return true
  end
end

def append_contents_to_file(src, dst)
  puts "cat #{src} >> #{dst}"
  contents = File.read(src)
  File.open(dst, "a") do |handle|
    handle.puts contents
  end
end