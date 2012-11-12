task :build => [:init] do
  
  # Packages  =>  Set up the Git submodule
  # WebBlocks =>  Set up the temp directories and create _WebBlocks.scss linker
  execute "preprocess"
  
  # Packages  =>  Compile if submodule does not come precompiled
  # WebBlocks =>  Execute the Compass/SASS compiler with _WebBlocks.scss linker
  execute "compile"
  
  # Packages  =>  Copy sources into temporary build files/directories
  # WebBlocks =>  Copy sources into temporary build files/directories
  execute "assemble"
  
  # WebBlocks =>  Copy temporary build files/directories to final build location
  execute "package"
  
end