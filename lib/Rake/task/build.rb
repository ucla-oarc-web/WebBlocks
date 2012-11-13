task :build => [:init] do
  
  # Packages  =>  Set up the Git submodule
  # Adapters  =>  Set up the Git submodule
  # WebBlocks =>  Set up the temp directories and create _WebBlocks.scss file
  execute "preprocess"
  
  # Adapters  =>  Define linkages in the _WebBlocks.scss file
  execute "link"
  
  # Packages  =>  Compile if submodule does not come precompiled
  # WebBlocks =>  Execute the Compass/SASS compiler with _WebBlocks.scss file
  execute "compile"
  
  # Packages  =>  Copy sources into temporary build files/directories
  # WebBlocks =>  Copy sources into temporary build files/directories
  execute "assemble"
  
  # WebBlocks =>  Copy temporary build files/directories to final build location
  execute "package"
  
  # Packages  =>  Hook in after the build has been packaged
  # Adapters  =>  Hook in after the build has been packaged
  execute "postprocess"
  
end