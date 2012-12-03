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

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'lib/Rake'
include WebBlocks::Rake
run

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end
