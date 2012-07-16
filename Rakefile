require 'rake'
require 'pathname'
require 'fileutils'
load 'Rakefile-configure.rb'

tmp_main_css = "#{DIR_BUILD_TMP}/#{DIR_BUILD_CSS}/#{FILE_MAIN_CSS}"
tmp_main_js = "#{DIR_BUILD_TMP}/#{DIR_BUILD_JS}/#{FILE_MAIN_JS}"
tmp_ie_css = "#{DIR_BUILD_TMP}/#{DIR_BUILD_CSS}/#{FILE_IE_CSS}"
tmp_ie_js = "#{DIR_BUILD_TMP}/#{DIR_BUILD_JS}/#{FILE_IE_JS}"

main_css = "#{DIR_BUILD}/#{DIR_BUILD_CSS}/#{FILE_MAIN_CSS}"
main_js = "#{DIR_BUILD}/#{DIR_BUILD_JS}/#{FILE_MAIN_JS}"
ie_css = "#{DIR_BUILD}/#{DIR_BUILD_CSS}/#{FILE_IE_CSS}"
ie_js = "#{DIR_BUILD}/#{DIR_BUILD_JS}/#{FILE_IE_JS}"

#
# primary tasks
#

task :default => [:build]

task :build => [:clean, :build_execute, :build_cleanup]

task :build_all => [:clean_all, :packages_update, :build]

task :clean => [:build_cleanup] do
  FileUtils.rm_rf DIR_BUILD if File.exist?(DIR_BUILD)
end

task :clean_all => [:packages_clean, :clean]

task :check do
  puts "WARNING: this does not necessarily work with non-default CMD paths"
  fail "git [#{CMD_GIT}] must be installed" unless executable_exists(CMD_GIT)
  fail "grunt [#{CMD_GRUNT}] must be installed (run \"npm -g install grunt\")" unless executable_exists(CMD_GRUNT)
  fail "npm [#{CMD_NPM}] must be installed" unless executable_exists(CMD_NPM)
  fail "uglifycss [#{CMD_UGLIFYCSS}] must be installed (run \"npm -g install uglifycss\")" unless executable_exists(CMD_UGLIFYCSS)
  fail "uglifyjs [#{CMD_UGLIFYJS}] must be installed (run \"npm -g install uglify-js\")" unless executable_exists(CMD_UGLIFYJS)
  fail "sass [#{CMD_SASS}] must be installed (run \"gem install sass\")" unless executable_exists(CMD_SASS)
  puts "prerequisite check successful"
end

#
# build subtasks
#

task :build_setup do
  
  mkdir DIR_BUILD_TMP unless File.exist? DIR_BUILD_TMP
  mkdir "#{DIR_BUILD_TMP}/#{DIR_BUILD_CSS}" unless File.exist? "#{DIR_BUILD_TMP}/#{DIR_BUILD_CSS}"
  mkdir "#{DIR_BUILD_TMP}/#{DIR_BUILD_JS}" unless File.exist? "#{DIR_BUILD_TMP}/#{DIR_BUILD_JS}"
  mkdir "#{DIR_BUILD_TMP}/#{DIR_BUILD_IMG}" unless File.exist? "#{DIR_BUILD_TMP}/#{DIR_BUILD_IMG}"
  File.open tmp_main_css, "w" unless File.exist? tmp_main_css
  File.open tmp_main_js, "w" unless File.exist? tmp_main_js
  File.open tmp_ie_css, "w" unless File.exist? tmp_ie_css
  File.open tmp_ie_js, "w" unless File.exist? tmp_ie_js
  
end

task :build_execute => [
  :build_setup,
  PACKAGES.include?("jquery") ? :_build_package_jquery : :skip,
  PACKAGES.include?("bootstrap") ? :_build_package_bootstrap : :skip,
  PACKAGES.include?("modernizr") ? :_build_package_modernizr : :skip,
  PACKAGES.include?("respond") ? :_build_package_respond : :skip,
  PACKAGES.include?("selectivizr") ? :_build_package_selectivizr : :skip
] do
  
  mkdir DIR_BUILD unless File.exist? DIR_BUILD
  
  FileUtils.cp_r "#{DIR_BUILD_TMP}/#{DIR_BUILD_IMG}", "#{DIR_BUILD}/#{DIR_BUILD_IMG}"
  mkdir "#{DIR_BUILD}/#{DIR_BUILD_CSS}" unless File.exist? "#{DIR_BUILD}/#{DIR_BUILD_CSS}"
  mkdir "#{DIR_BUILD}/#{DIR_BUILD_JS}" unless File.exist? "#{DIR_BUILD}/#{DIR_BUILD_JS}"
  
  sh "#{CMD_UGLIFYCSS} \"#{tmp_main_css}\" > \"#{main_css}\""
  sh "#{CMD_UGLIFYJS} \"#{tmp_main_js}\" --extras --unsafe >> \"#{main_js}\""
  sh "#{CMD_UGLIFYCSS} \"#{tmp_ie_css}\" > \"#{ie_css}\""
  sh "#{CMD_UGLIFYJS} \"#{tmp_ie_js}\" --extras --unsafe >> \"#{ie_js}\""
  
  
end

task :build_cleanup do
  FileUtils.rm_rf DIR_BUILD_TMP if File.exist?(DIR_BUILD_TMP)
end

task :skip do
  next
end

#
# build package subtasks
# 

task :_build_package_jquery => [:build_setup, :package_jquery_build] do
  append_contents_to_file "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}/dist/jquery.min.js", tmp_main_js
end

task :_build_package_bootstrap => [:build_setup] do
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["bootstrap"]}"
  sh "#{CMD_SASS} --precision 10 --load-path src/css/lib --load-path #{package_dir}/lib/ --style expanded src/css/site.scss \"#{tmp_main_css}\""
  PACKAGE_BOOTSTRAP_SCRIPTS.each do |script|
    append_contents_to_file "#{package_dir}/js/bootstrap-#{script}.js", tmp_main_js
  end 
  Dir.entries("#{package_dir}/img/").each do |name|
    FileUtils.cp "#{package_dir}/img/#{name}", "#{DIR_BUILD_TMP}/img" unless File.directory? "#{package_dir}/img/#{name}"
  end
end

task :_build_package_modernizr => [:build_setup] do
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["modernizr"]}"
  append_contents_to_file "#{package_dir}/modernizr.js", tmp_main_js
end

task :_build_package_respond => [:build_setup] do
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["respond"]}"
  append_contents_to_file "#{package_dir}/respond.min.js", tmp_ie_js
end

task :_build_package_selectivizr => [:build_setup] do
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["selectivizr"]}"
  append_contents_to_file("#{package_dir}/selectivizr.js", tmp_ie_js)
end

#
# package tasks
# 

task :packages_build => [:packages_clean, :package_jquery_build]

task :packages_clean => [:package_jquery_clean]

task :packages_update => [:packages_clean, :package_update, :package_jquery_update]

task :package_update do
  sh "#{CMD_GIT} submodule init"
  sh "#{CMD_GIT} submodule update"
end

task :package_jquery_build do
  if File.exist? "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}/dist"
    puts "Skipping build_jquery as #{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}/dist already exists"
    next
  end
  pwd = Dir.pwd
  Dir.chdir "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
  sh "#{CMD_NPM} install"
  sh "#{CMD_GRUNT}"
  Dir.chdir pwd
end

task :package_jquery_clean do
  FileUtils.rm_rf "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}/dist"
end

task :package_jquery_update do
  pwd = Dir.pwd
  jquery_package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
  Dir.chdir(jquery_package_dir)
  sh "#{CMD_GIT} submodule init"
  sh "#{CMD_GIT} submodule update"
  Dir.chdir(pwd)
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