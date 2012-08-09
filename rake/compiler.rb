module WebBlocks
  
  class Compiler
    
    attr_accessor :src, :dst, :mods, :adapter, :sass_dir
    
    def initialize src, dst, mods = ['core'], adapter = 'bootstrap', sass_dir = 'sass'
      
      @sass_dir = sass_dir
      @src = src
      @dst = dst
      @mods = mods
      @adapter = adapter
      
    end
    
    def ext? file, ext
      ext = ext.join '|' if ext.respond_to? 'join'
      file.match(/.*\.(#{ext})$/)
    end
    
    def scss? file
      ext? file, 'scss'
    end
    
    def js? file
      ext? file, 'js'
    end
    
    def img? file
      ext? file, ['jpg', 'jpeg', 'gif', 'png', 'bmp', 'tif', 'svg']
    end
    
    def generate
      
      pwd = Dir.pwd
      Dir.chdir @src
      
      FileUtils.rm_rf "tmp" if File.exists? "tmp";
      mkdir "tmp";
      
      scss = File.open "tmp/_WebBlocks.scss", "w"
      js = File.open "../#{@dst}/js/blocks.js", "a"
      scss.puts "@import \"variables\";"
      
      @mods.unshift "adapter/#{@adapter}"
      @mods.each do |mod|
        tree = get_tree mod
        tree.flatten.each do |file|
          case
          when scss?(file)
            puts "[WebBlocks::Compiler scss] #{file}"
            file.chomp! ".scss";
            scss.puts "@import \"#{file}\";"
          when js?(file)
            puts "[WebBlocks::Compiler js] #{file}"
            contents = File.read(file)
            js.puts contents
          when img?(file)
            puts "[WebBlocks::Compiler img] #{file}"
            dst = "../#{@dst}/img/#{file}"
            FileUtils.mkdir_p(File.dirname(dst))
            FileUtils.cp file, dst
          end
        end
      end
      
      scss.close
      js.close
      
      puts "compass compile --sass-dir #{@sass_dir} --css-dir ../#{@dst}/css" 
      sh "compass compile --sass-dir #{@sass_dir} --css-dir ../#{@dst}/css" 
      
      FileUtils.rm_rf "tmp" if File.exists? "tmp";
      
      Dir.chdir pwd
      
    end
    
    def get_tree path
      
      contents = []
      
      contents.push path if File.file? path
      
      dir = File.dirname path
      Dir.entries(dir).each do |child|
        contents.push "#{dir}/#{child}" if child.match(/^_?(#{File.basename path})\..*/)
      end

      return contents unless FileTest.directory? path
      
      Dir.entries(path).each do |child|
        contents.push get_tree "#{path}/#{child}" unless child[0,1] == '.'
      end
      
      return contents
      
    end
    
    def execute
      
      self.generate
      
    end
    
  end
  
end