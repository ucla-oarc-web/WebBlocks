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

task :init do
  
  invoke builder.blocks, :init unless builder.blocks.init?
  
end

task :build     => [:init] do
  
  invoke builder.packages, :build
  invoke builder.blocks, :build
  
end

task :build_all => [:init] do
  
  invoke builder.packages, :rebuild
  invoke builder.blocks, :build
  
end

task :clean => [:init] do
  
  invoke builder.blocks, :clean
  
end

task :clean_all => [:clean] do
  
  invoke builder.packages, :clean
  
end

task :reset => [:clean_all] do
  
  invoke builder.blocks, :reset
  invoke builder.packages, :reset
  
end

task :check do
  # TODO
end

task :environment => [:paths, :packages, :includes]

task :packages do
  # TODO
end

task :includes do
  # TODO
end

task :paths do
  # TODO
end

#
# helper functions
#

def invoke object, method
  if object.respond_to? :each
    object.each { |obj| invoke obj, method }
  elsif object.respond_to? method
    puts "[INVOKE] #{object.class.name}.#{method}"
    object.send(method)
  end
end
