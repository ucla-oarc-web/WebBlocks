task :build_css => [:init] do
  
  # see build.rb for documentation on execution steps
  
  execute "preprocess_css"
  execute "link_css"
  execute "compile_css"
  execute "assemble_css"
  execute "package_css"
  execute "postprocess_css"
  
end