task :build_js => [:init] do
  
  # see build.rb for documentation on execution steps
  
  execute "preprocess_js"
  execute "link_js"
  execute "compile_js"
  execute "assemble_js"
  execute "package_js"
  execute "postprocess_js"
  
end