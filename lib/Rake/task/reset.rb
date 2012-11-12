task :reset => [:init, :reset_packages] do
  
  execute "reset"
  
end