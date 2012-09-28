#
# Blocks Builder
# 
# This builder is used to build WebBlocks itself as mediated for use through the
# WebBlocks::Builder build manager with methods invoked from the Rakefile.
# 
# This builder responds to several build methods:
# 
# => init
# => init?
# => reset
# => build_setup
# => build
# => build_cleanup
# => built?
# => clean
# 
# In the case of the build method, this builder is assumed to be invoked after 
# the package builders, as it is responsible for taking all CSS, JS, and images 
# and placing them in their final build locations after it invokes the
# WebBlocks::Build::Blocks::Compiler to generate CSS from the SASS files.
#

require 'fileutils'
require 'pathname'
require 'systemu'
load "#{File.dirname(File.dirname(Pathname.new(__FILE__).realpath))}/util.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/builder.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/compiler.rb"
load "#{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/compiler.rb"

module WebBlocks
  
  module Build
    
    class Blocks < Builder
      
      # Initialization defines the WebBlocks metadata directory
      def init
        
        @log.task "Builder", "Defining WebBlocks metadata" do
          FileUtils.mkdir_p dir_build_metadata unless init?
        end
        
      end
      
      # Initialized if the WebBlocks metadata directory exists
      def init?
        
        File.exists? dir_build_metadata
        
      end
      
      # Reset removes the WebBlocks metadata directory
      def reset
        
        @log.task "Builder", "Resetting WebBlocks to initial state" do
          FileUtils.rm_rf dir_build_metadata
        end
        
      end
      
      # Build setup invokes creating the temporary build location where the 
      # WebBlocks build occurs. This ensures that a partial build will not
      # trash a successful build already residing in the build directory.
      def build_setup
        
        @log.failure "Builder", "Temporary build directory already exists [run `rake clean` to resolve]" if File.exists? dir_build_temp
        
        @log.task "Builder", "Setting up temporary build region" do
          FileUtils.mkdir_p dir_build_temp and @log.info "Created directory: #{dir_build_temp}"
          FileUtils.touch file_build_temp_css and @log.info "Created core CSS target: #{file_build_temp_css}"
          FileUtils.touch file_build_temp_css_ie and @log.info "Created IE CSS target: #{file_build_temp_css_ie}"
          FileUtils.touch file_build_temp_js and @log.info "Created core JS target: #{file_build_temp_js}"
          FileUtils.touch file_build_temp_js_ie and @log.info "Created IE JS target: #{file_build_temp_js_ie}"
          FileUtils.mkdir_p dir_build_temp_js and @log.info "Created scripts JS target: #{file_build_temp_js_ie}"
          FileUtils.mkdir_p dir_build_temp_img and @log.info "Created images target: #{file_build_temp_js_ie}"
        end
        
      end
      
      # Building WebBlocks involves several steps:
      #
      # => Compile WebBlocks via WebBlocks::Build::Blocks::Compiler
      # => Append files built into the css directory into the CSS build files
      # => Copy files from the compile process (and package builders) into build
      #
      # The third step thus requires that the package builders have already
      # been run, as otherwise it will fail to copy assets composed by the
      # package builders into the build directory.
      def build
        
        @log.task "Builder", "Compiling WebBlocks" do
          compiler = WebBlocks::Build::Blocks::Compiler.new @config, @log
          compiler.compile
        end
        
        @log.task "Builder", "Appending compiled CSS to build" do
          WebBlocks::Util.get_files(dir_build_temp_css, 'css').each do |file|
            append_contents_to_file file, (file.match(/.*\-ie.css$/) ? file_build_temp_css_ie : file_build_temp_css)
          end
        end
        
        @log.task "Builder", "Copying build from temporary region into build targets" do
        
          # Copy files to build directory

          FileUtils.mkdir_p @config[:build][:dir] unless File.exists? @config[:build][:dir]
          Dir.chdir @config[:build][:dir] do

            # Copy CSS files to build directory

            FileUtils.mkdir_p @config[:build][:css][:dir] unless File.exists? @config[:build][:css][:dir]
            Dir.chdir @config[:build][:css][:dir] do

              src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css
              dst = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:css][:name]
              FileUtils.mkdir_p File.dirname(dst)
              log.info "Copying core CSS file" do
                log.debug "src: #{src}"
                log.debug "dst: #{dst}"
                FileUtils.cp src, dst
              end

              src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_css_ie
              dst = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:css][:name_ie]
              FileUtils.mkdir_p File.dirname(dst)
              log.info "Copying IE CSS file" do
                log.debug "src: #{src}"
                log.debug "dst: #{dst}"
                FileUtils.cp src, dst
              end

            end

            # Copy JS files to build directory

            FileUtils.mkdir_p @config[:build][:js][:dir] unless File.exists? @config[:build][:js][:dir]
            Dir.chdir @config[:build][:js][:dir] do

              src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js
              dst = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:js][:name]
              FileUtils.mkdir_p File.dirname(dst)
              log.info "Copying core JS file" do
                log.debug "src: #{src}"
                log.debug "dst: #{dst}"
                FileUtils.cp src, dst
              end

              src = WebBlocks::Util.file_from_root_through_dir_stack file_build_temp_js_ie
              dst = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:js][:name_ie]
              FileUtils.mkdir_p File.dirname(dst)
              log.info "Copying IE JS file" do
                log.debug "src: #{src}"
                log.debug "dst: #{dst}"
                FileUtils.cp src, dst
              end

              # Copy scripts to build directory. Note that this will overwrite
              # scripts defined in the build, but it will not delete scripts in
              # the script build directory that were not part of the build. To do 
              # this latter action, perform a git clean instead to remove the 
              # build directory completely.
              src_base_dir = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_js
              dst_base_dir = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:js][:name_script_dir]
              log.info "Copying JS script files" do
                log.debug "src: #{src_base_dir}"
                log.debug "dst: #{dst_base_dir}"
                log.debug "files:" do
                  WebBlocks::Util.get_files(src_base_dir).each do |src|
                    log.debug src.sub(/^#{src_base_dir}\//, '')
                    dst = "#{dst_base_dir}/#{src.sub /^#{src_base_dir}\//, ''}"
                    FileUtils.mkdir_p File.dirname(dst)
                    FileUtils.cp src, dst
                  end
                end
              end

            end

            # Copy image files to build directory. Note that this will overwrite
            # images defined in the build, but it will not delete images in the
            # image build directory that were not part of the build. To do this
            # latter action, perform a git clean instead to remove the build
            # directory completely.
            src_base_dir = WebBlocks::Util.dir_from_root_through_dir_stack dir_build_temp_img
            dst_base_dir = WebBlocks::Util.file_from_dir_stack Dir.pwd, @config[:build][:img][:dir]
            log.info "Copying image files" do
              log.debug "src: #{src_base_dir}"
              log.debug "dst: #{dst_base_dir}"
              log.debug "files:" do
                WebBlocks::Util.get_files(src_base_dir).each do |src|
                  dst = "#{dst_base_dir}/#{src.sub /^#{src_base_dir}\//, ''}"
                  FileUtils.mkdir_p File.dirname(dst)
                  FileUtils.cp src, dst
                end
              end
            end

          end

        end
      
      end
      
      # Build cleanup involves removing the temporary build region.
      def build_cleanup
        FileUtils.rm_rf dir_build_temp
      end
      
      # WebBlocks is built if a build directory exists. This is not the same
      # thing as being up-to-date, which is a method that maybe added later.
      def built?
        File.exists? dir_build
      end

      # Clean removes the build directory and ensures that the temporary build
      # region no longer exists (although this region should have been removed
      # by build_cleanup after the build routine).
      def clean
        build_cleanup
        FileUtils.rm_rf dir_build
      end
      
      #
      # Blocks Compiler
      # 
      # The blocks compiler is responsible for compiling the SASS sources into
      # the css directory of the temporary build region. 
      # 
      # To accomplish this, it first builds a _WebBlocks.scss file based on
      # includes as determined by adapters and extensions, and then it invokes
      # compass to actually build the CSS sources from SASS files residing in
      # the SASS source directory.
      # 
      # Part of this process involves invoking adapter compilers within 
      # WebBlocks::Build::Adapter as residing in rake/build/adapter. It also 
      # involves 
      # 
      # If config[:src][:modules] is set to anything but :all, it will select
      # only adapter mixins and core definitions from within the subdirectories
      # defined in config[:src][:modules]. However, for convience, it will also
      # include all files in all subdirectories of the adapters and core 
      # definitions that have the name _variables.scss or variables.scss, as
      # well as any files defined in the directory root of an adapter or the
      # core definitions.
      # 
      # When the import file is actually built, note that all variables files
      # are loaded before any other files, following the same load stack order
      # as other includes to allow for proper overriding.
      #
      
      class Compiler < WebBlocks::Build::Compiler
        
        attr_accessor :adapters
        attr_accessor :adapters_compilers
        attr_accessor :extensions
        attr_accessor :modules
        attr_accessor :file_build_temp_sass
        attr_accessor :dir_build_temp_img
        attr_accessor :dir_src_sass
        attr_accessor :dir_src_core
        attr_accessor :dir_src_core_definitions
        attr_accessor :dir_src_core_adapter
        attr_accessor :file_src_core_compass_config
        attr_accessor :dir_src_extensions
        
        def initialize config, log
          
          super config, log
          
          @file_build_temp_sass = "#{dir_build_temp_sass}/_WebBlocks.scss"
          @dir_build_temp_img = "#{dir_build_temp}/img"
          @dir_build_temp_script = "#{dir_build_temp}/script"
          @dir_build_temp_css = "#{dir_build_temp}/css"
          @dir_src_sass = WebBlocks::Util.dir_from_root_through_dir_stack dir_src, @config[:src][:sass][:dir]
          @dir_src_sass_includes = WebBlocks::Util.dir_from_dir_stack @dir_src_sass, @config[:src][:sass][:includes][:dir]
          @dir_src_core = WebBlocks::Util.dir_from_root_through_dir_stack dir_src, @config[:src][:core][:dir]
          @dir_src_core_definitions = WebBlocks::Util.dir_from_dir_stack @dir_src_core, @config[:src][:core][:definitions][:dir]
          @dir_src_core_adapter = WebBlocks::Util.dir_from_root_through_dir_stack @dir_src_core, @config[:src][:core][:adapter][:dir]
          @dir_src_extensions = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:extension][:dir]
          @dir_src_js = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:js][:dir]
          @dir_src_js_core = WebBlocks::Util.dir_from_dir_stack @dir_src_js, @config[:src][:js][:core][:dir]
          @dir_src_js_core_ie = WebBlocks::Util.dir_from_dir_stack @dir_src_js, @config[:src][:js][:core_ie][:dir]
          @dir_src_js_script = WebBlocks::Util.dir_from_dir_stack @dir_src_js, @config[:src][:js][:script][:dir]
          @dir_src_img = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:img][:dir]
          @dir_src_css = WebBlocks::Util.dir_from_dir_stack dir_src, @config[:src][:css][:dir]
          @file_src_core_compass_config = WebBlocks::Util.file_from_dir_stack @dir_src_core, @config[:src][:core][:compass][:config]
          
          @log.info "Compiler", "Defining paths" do
            @log.debug "Source Directory: #{dir_src}" do
              @log.debug "SASS Sources: #{@dir_src_sass.sub /^#{dir_src}\//, ''}" do
                @log.debug "Includes Directory: #{@dir_src_sass_includes.sub /^#{@dir_src_sass}\//, ''}"
              end
              @log.debug "Core Sources: #{@dir_src_core.sub /^#{dir_src}\//, ''}" do
                @log.debug "Definitions: #{@dir_src_core_definitions.sub /^#{@dir_src_core}\//, ''}"
                @log.debug "Adapter: #{@dir_src_core_adapter.sub /^#{@dir_src_core}\//, ''}"
                @log.debug "Compass Config: #{@file_src_core_compass_config.sub /^#{@dir_src_core}\//, ''}"
              end
              @log.debug "JS Sources: #{@dir_src_js.sub /^#{dir_src}\//, ''}" do
                @log.debug "Core: #{@dir_src_js_core.sub /^#{@dir_src_js}\//, ''}"
                @log.debug "Core IE: #{@dir_src_js_core_ie.sub /^#{@dir_src_js}\//, ''}"
                @log.debug "Scripts: #{@dir_src_js_script.sub /^#{@dir_src_js}\//, ''}"
              end
              @log.debug "Image Sources: #{@dir_src_img.sub /^#{dir_src}\//, ''}"
              @log.debug "Extensions: #{@dir_src_extensions.sub /^#{dir_src}\//, ''}"
            end
            @log.debug "Temporary Build Directory: #{dir_build_temp}" do
              @log.debug "SASS Includes File: #{@file_build_temp_sass.sub /^#{dir_build_temp}\//, ''}"
              @log.debug "JS Scripts Directory: #{@dir_build_temp_img.sub /^#{dir_build_temp}\//, ''}"
              @log.debug "Image Directory: #{@dir_build_temp_img.sub /^#{dir_build_temp}\//, ''}"
            end
          end
          
          if @config[:src][:adapter]
            @adapters = (@config[:src][:adapter].respond_to? :each) ? @config[:src][:adapter] : [@config[:src][:adapter]]
          else
            @adapters = []
          end
          
          @log.info "Compiler", "Building adapter compilers" do
            
            @adapters_compilers = []
          
            # An adapter is unshifted onto the front of the array of adapter
            # compilers for the actual core adapter, as its mixins should load
            # first to ensure that there are no undefined mixins during load.
            # Adapters defined later in the set will include overrides of the
            # mixins defined in the core adapter.
            @log.info "core adapter" do
              @log.debug "Definition: #{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/compiler.rb"
              @log.debug "Class: WebBlocks::Build::Adapter::Compiler"
              @log.debug "Name: #{@dir_src_core_adapter}"
              @adapters_compilers.push WebBlocks::Build::Adapter::Compiler.new @config, @log, @dir_src_core_adapter
            end
            
            # Build the adapter compilers. For the adapter 'name', it will 
            # construct a compiler WebBlocks::Build::Adapter::Name as defined in
            # /rake/build/adapter/name.rb. If one does not exist, then it will
            # construct the compiler WebBlocks::Build::Adapter::Compiler as
            # defined in /rake/build/adapter/compiler.rb. This is convinient as
            # not all adapters need custom behavior.
            @adapters.each do |name|
              @log.info "#{name.to_s} adapter" do
                file = "#{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/#{name.to_s}.rb"
                if File.exists? file
                  @log.debug "Definition: #{file}"
                  load file
                  classname = eval "WebBlocks::Build::Adapter::#{name.to_s.capitalize}"
                  begin
                    @adapters_compilers.push(classname.new @config, @log)
                    @log.debug "Class: WebBlocks::Build::Adapter::#{name.to_s.capitalize}"
                  rescue
                    @log.failure "Class: WebBlocks::Build::Adapter::#{name.to_s.capitalize} undefined"
                  end
                else
                  @log.debug "Definition: #{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/compiler.rb"
                  @log.debug "Class: WebBlocks::Build::Adapter::Compiler"
                  @log.debug "Name: #{name.to_s.downcase}"
                  @adapters_compilers.push(WebBlocks::Build::Adapter::Compiler.new @config, @log, name.to_s.downcase)
                end
              end
            end

            # Core definitions can conviniently also be built via a compiler.
            # However, they are included separately as they load after extensions,
            # which are not compiled via an adapter.
            @log.info "core definitions" do
              @log.debug "Definition: #{File.dirname(Pathname.new(__FILE__).realpath)}/adapter/compiler.rb"
              @log.debug "Class: WebBlocks::Build::Adapter::Compiler"
              @log.debug "Name: #{@dir_src_core_definitions}"
              @core_definitions_compiler = WebBlocks::Build::Adapter::Compiler.new @config, @log, @dir_src_core_definitions
            end
            
          end
            
          if @config[:src][:extensions]
            @extensions = (@config[:src][:extensions].respond_to? :each) ? @config[:src][:extensions] : [@config[:src][:extensions]]
          else
            @extensions = []
          end
          
          @log.info "Compiler", "Defining extensions for inclusion" do
            @extensions.each do |ext|
              @log.debug ext
            end
          end
          
          if @config[:src][:modules] == :all
            @modules = []
            get_modules(dir_src_core_definitions, false).each do |mod|
              @modules.push mod.sub /^#{Regexp.escape(dir_src_core_definitions)}\//, ''
            end
          elsif @config[:src][:modules]
            @modules = (@config[:src][:modules].respond_to? :each) ? @config[:src][:modules] : [@config[:src][:modules]]
          else
            @modules = []
          end
          
          @log.info "Compiler", "Defining modules for inclusion" do
            @modules.each do |mod|
              @log.debug mod
            end
          end
          
        end
        
        # Determine the path to an extension by name path
        def dir_src_extension path
          WebBlocks::Util.dir_from_dir_stack dir_src_extensions, path
        end
        
        # Determine the path to a core definition by name path
        def dir_src_core_definition path
          WebBlocks::Util.dir_from_dir_stack dir_src_core_definitions, path
        end
        
        # The compile routine involves several phases:
        # 
        # => Create the SASS import file based on import priority rules
        # => Run the Compass compiler on the SASS sources with import file
        # => Append Javascript stored within the modules into core[-ie].js
        #
        # TODO: Add -ie.scss impot file as well
        def compile
          
          @log.task "Compiler", "Appending Javascript sources" do
            append_javascript 
          end
          
          @log.task "Compiler", "Copy image sources" do
            copy_images
          end
          
          @log.task "Compiler", "Generating SASS import file" do
            create_sass_import_file file_build_temp_sass
          end
          
          @log.task "Compiler", "Running Compass compiler" do
            run_compass_compiler
          end
          
          @log.task "Compiler", "Copy CSS sources" do
            copy_css
          end
          
        end
        
        # Import file is generated with the included SCSS files as determined
        # by included_scss_files. The output file will include nothing but a
        # large set of @import lines.
        def create_sass_import_file file
          FileUtils.mkdir_p File.dirname(file)
          File.open file, "w" do |scss|
            @log.info "Compiler", "Defining import rules" do
              included_scss_files.each do |include|
                @log.debug include
                scss.puts "@import \"#{include}\";"
              end
            end
          end
        end
        
        # Runs the Compass compiler on the SASS sources folder using the
        # import file generated earlier in the compile routine by the
        # create_sass_import_file method.
        def run_compass_compiler
          success = true
          environment = @config[:build][:debug] ? "development" : "production"
          Dir.chdir @config[:build][:dir_tmp] do
            status, stdout, stderr = systemu "compass compile -e #{environment} --boring --sass-dir #{dir_src_sass} --config \"#{@file_src_core_compass_config}\""
            success = false if status != 0
            if success
              @log.debug stdout
            else
              @log.failure "Compiler", "Compass compile error"
            end
            # cleanup SASS includes directory if its within the SASS source directory
            # as it should not be appended later in execution
            if @dir_src_sass_includes.match /^#{dir_src_sass}\//
              relname = @dir_src_sass_includes.sub /^#{dir_src_sass}\//, ''
              FileUtils.rm_rf "#{@dir_build_temp_css}/#{relname}"
            end
          end
        end
        
        # Append Javascript from adapters, JS core source and JS core-ie source.
        def append_javascript
          
          # Append Javascript residing within the adapters. These includes use
          # the same rules as SASS includes concerning module settings, so a JS
          # file not within an included module will not be included.
          @log.info "Compiler", "Appending adapter JS to core/IE JS files" do
            @adapters_compilers.each do |adapter_compiler|
                adapter_compiler.included_adapter_module_files(@modules, 'js').each do |file|
                @log.debug file
                if @config[:build][:debug]
                  append_contents_to_file file, (file.match(/.*\-ie.js$/) ? file_build_temp_js_ie : file_build_temp_js)
                else
                  append_compressed_js_to_file file, (file.match(/.*\-ie.js$/) ? file_build_temp_js_ie : file_build_temp_js)
                end
              end
            end
          end
          
          # Append all files from JS core sources
          @log.info "Compiler", "Appending JS core sources to JS core file" do
            WebBlocks::Util.get_files(@dir_src_js_core, 'js').each do |file|
              @log.debug file
              if @config[:build][:debug]
                append_contents_to_file file, file_build_temp_js
              else
                append_compressed_js_to_file file, file_build_temp_js
              end
            end
          end
          
          # Append all files from JS core-ie sources
          @log.info "Compiler", "Appending JS IE sources to JS IE file" do
            WebBlocks::Util.get_files(@dir_src_js_core_ie, 'js').each do |file|
              @log.debug file
              if @config[:build][:debug]
                append_contents_to_file file, file_build_temp_js_ie
              else
                append_compressed_js_to_file file, file_build_temp_js_ie
              end
            end
          end
          
          # Copy all files from JS scripts dir to temporary scripts dir
          @log.info "Compiler", "Copying JS script sources to JS scripts directory" do
            WebBlocks::Util.get_files(@dir_src_js_script, 'js').each do |file|
              @log.debug file
              dst = "#{@dir_build_temp_script}/#{file.sub /^#{@dir_src_js_script}\//, ''}"
              FileUtils.mkdir_p File.dirname(dst)
              FileUtils.cp file, dst
            end
          end
          
        end
        
        def copy_css
          
          @log.info "Compiler", "Copying source CSS to CSS directory" do
            WebBlocks::Util.get_files(@dir_src_css, 'css').each do |file|
              @log.debug file
              dst = "#{@dir_build_temp_css}/#{file.sub /^#{@dir_src_css}\//, ''}"
              FileUtils.mkdir_p File.dirname(dst)
              FileUtils.cp file, dst
            end
          end
          
        end
        
        def copy_images
          
          img_exts = ['jpg','jpeg','gif','png','bmp','svg']
          
          @log.info "Compiler", "Copying adapter images to image directory" do
            @adapters_compilers.each do |adapter_compiler|
              adapter_compiler.included_adapter_module_files(@modules, img_exts).each do |src|
                @log.debug src
                relsrc = src.sub /^#{adapter_compiler.dir_src_adapter}\//, ''
                dst = "#{@dir_build_temp_img}/#{relsrc}"
                FileUtils.mkdir_p File.dirname(dst)
                FileUtils.cp src, dst
              end
            end
          end
          
          @log.info "Compiler", "Copying source images to image directory" do
            WebBlocks::Util.get_files(@dir_src_img, img_exts).each do |file|
              @log.debug file
              dst = "#{@dir_build_temp_img}/#{file.sub /^#{@dir_src_img}\//, ''}"
              FileUtils.mkdir_p File.dirname(dst)
              FileUtils.cp file, dst
            end
          end
          
        end
        
        # Determines included files of type ext as determined by the adapter
        # compilers, all extension files of the type ext, and the core
        # definitions.
        def included_files ext
          files = []
          @adapters_compilers.each do |adapter_compiler|
            files.push adapter_compiler.included_adapter_module_files(@modules, ext)
          end
          @extensions.each do |path|
            files.push get_files(dir_src_extension(path), ext)
          end
          files.push @core_definitions_compiler.included_adapter_module_files(@modules, ext)
          files.flatten
        end
        
        # Essentially a call-forward to included_files to get SASS files in the
        # order [core adapter]-[adapters]-[extensions]-[core definitions],
        # except that it reordered all _variables.scss and variables.scss to
        # be loaded first in the overall call stack. This ensures that variables
        # will be loaded before they are needed.
        def included_scss_files
          files = [[],[]]
          [included_files("scss"), get_files(@dir_src_sass_includes, "scss")].flatten.each do |file|
            if File.basename(file) == '_variables.scss' or File.basename(file) == 'variables.scss'
              files[0].push file
            else
              files[1].push file
            end
          end
          files[0].push "#{dir_src_sass}/_variables.scss" if File.exists? "#{dir_src_sass}/_variables.scss"
          files.flatten
        end
        
        # Call-forward to included_files with the JS extension. No ordering is
        # assumed (unless included_scss_files) except that they follow the
        # [core adapter]-[adapters]-[extensions]-[core definitions] order.
        def included_js_files
          included_files "js"
        end
        
      end
      
    end
    
  end
  
end