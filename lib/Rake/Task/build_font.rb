task :build_font => [:init] do
  
  # see build.rb for documentation on execution steps
  
  execute "preprocess_font"
  execute "link_font"
  execute "compile_font"
  execute "assemble_font"
  execute "package_font"
  execute "postprocess_font"
  
end