require 'rake'
require 'pathname'
require 'fileutils'
load 'Rakefile-configure.rb'

def executable_exists(name)
  if system("which #{name}") == nil and system("where #{name}") == false
    return false
  else
    return true
  end
end

task :check do
  puts "WARNING: this does not necessarily work with non-default CMD paths"
  if !executable_exists(CMD_GIT)
    fail "git [#{CMD_GIT}] must be installed"
  end
  if !executable_exists(CMD_GRUNT)
    fail "grunt [#{CMD_GRUNT}] must be installed (run \"npm -g install grunt\")"
  end
  if !executable_exists(CMD_NPM)
    fail "npm [#{CMD_NPM}] must be installed"
  end
  if !executable_exists(CMD_UGLIFYCSS)
    fail "uglifycss [#{CMD_UGLIFYCSS}] must be installed (run \"npm -g install uglifycss\")"
  end
  if !executable_exists(CMD_UGLIFYJS)
    fail "uglifyjs [#{CMD_UGLIFYJS}] must be installed (run \"npm -g install uglify-js\")"
  end
  if !executable_exists(CMD_SASS)
    fail "sass [#{CMD_SASS}] must be installed (run \"gem install sass\")"
  end
  puts "prerequisite check successful"
end

task :packages do
  sh "#{CMD_GIT} submodule init"
  sh "#{CMD_GIT} submodule update"
  pwd = Dir.pwd
  jquery_package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
  Dir.chdir(jquery_package_dir)
  sh "#{CMD_GIT} submodule init"
  sh "#{CMD_GIT} submodule update"
  Dir.chdir(pwd)
end

task :build => [:packages] do
  
  begin
  
    mkdir DIR_BUILD_TMP

    tmp_main_css = "#{DIR_BUILD_TMP}/#{FILE_MAIN_CSS}"
    tmp_main_js = "#{DIR_BUILD_TMP}/#{FILE_MAIN_JS}"
    tmp_ie_css = "#{DIR_BUILD_TMP}/#{FILE_IE_CSS}"
    tmp_ie_js = "#{DIR_BUILD_TMP}/#{FILE_IE_JS}"

    File.open tmp_main_css, "w"
    File.open tmp_main_js, "w"
    File.open tmp_ie_css, "w"
    File.open tmp_ie_js, "w"
    
    if PACKAGES.include?("jquery")
      build_jquery(tmp_main_js)
    end

    if PACKAGES.include?("bootstrap")
      build_bootstrap(tmp_main_css, tmp_main_js)
    end

    if PACKAGES.include?("modernizr")
      build_modernizr(tmp_main_js)
    end

    if PACKAGES.include?("respond")
      build_respond(tmp_ie_js)
    end

    if PACKAGES.include?("selectivizr")
      build_selectivizr(tmp_ie_js)
    end
    
    if !File.exist?(DIR_BUILD)
      mkdir DIR_BUILD
    end

    main_css = "#{DIR_BUILD}/#{FILE_MAIN_CSS}"
    main_js = "#{DIR_BUILD}/#{FILE_MAIN_JS}"
    ie_css = "#{DIR_BUILD}/#{FILE_IE_CSS}"
    ie_js = "#{DIR_BUILD}/#{FILE_IE_JS}"

    sh "#{CMD_UGLIFYCSS} \"#{tmp_main_css}\" > \"#{main_css}\""
    sh "#{CMD_UGLIFYJS} \"#{tmp_main_js}\" --extras --unsafe >> \"#{main_js}\""
    
    sh "#{CMD_UGLIFYCSS} \"#{tmp_ie_css}\" > \"#{ie_css}\""
    sh "#{CMD_UGLIFYJS} \"#{tmp_ie_js}\" --extras --unsafe >> \"#{ie_js}\""
    
  ensure

    FileUtils.rm_rf DIR_BUILD_TMP
    
  end
  
end

task :clean do
  if File.exist?(DIR_BUILD_TMP)
    FileUtils.rm_rf DIR_BUILD_TMP
  end
  if File.exist?(DIR_BUILD)
    FileUtils.rm_rf DIR_BUILD
  end
end

task :default => [:clean, :build]


# build methods

def build_jquery(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["jquery"]}"
  pwd = Dir.pwd
  Dir.chdir(package_dir)
  sh "#{CMD_NPM} install"
  sh "#{CMD_GRUNT}"
  Dir.chdir(pwd)
  append_contents_to_file("#{package_dir}/dist/jquery.min.js", js_path)
end

def build_bootstrap(css_path, js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["bootstrap"]}"
  sh "#{CMD_SASS} --precision 10 --load-path src/css/lib --load-path #{package_dir}/lib/ --style expanded src/css/site.scss \"#{css_path}\""
  sh "#{CMD_SASS} --precision 10 --load-path src/css/lib --load-path #{package_dir}/lib/ --style expanded src/css/site-responsive.scss \"#{css_path}\""
  PACKAGE_BOOTSTRAP_SCRIPTS.each do |script|
    append_contents_to_file("#{package_dir}/js/bootstrap-#{script}.js", js_path)
  end 
end

def build_modernizr(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["modernizr"]}"
  append_contents_to_file("#{package_dir}/modernizr.js", js_path)
end

def build_respond(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["respond"]}"
  append_contents_to_file("#{package_dir}/respond.min.js", js_path)
end

def build_selectivizr(js_path)
  package_dir = "#{DIR_PACKAGE}/#{DIR_PACKAGES["selectivizr"]}"
  append_contents_to_file("#{package_dir}/selectivizr.js", js_path)
end

def append_contents_to_file(src, dst)
  puts "cat #{src} >> #{dst}"
  contents = File.read(src)
  File.open(dst, "a") do |handle|
    handle.puts contents
  end
end