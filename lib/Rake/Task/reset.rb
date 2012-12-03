task :reset => [:init, :clean_all, :reset_packages] do
  
  execute "reset"
  
end