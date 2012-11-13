task :build_img => [:init] do
  
  # see build.rb for documentation on execution steps
  
  execute "preprocess_img"
  execute "link_img"
  execute "compile_img"
  execute "assemble_img"
  execute "package_img"
  execute "postprocess_img"
  
end