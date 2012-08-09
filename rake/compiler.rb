module WebBlocks
  
  class Compiler
    
    attr_accessor :src, :dst, :mods, :adapter
    
    def initialize src, dst, mods, adapter
      
      @src = src
      @dst = dst
      @mods = mods
      @adapter = adapter
      
    end
    
    def ext? file, ext
      (File.extname file) == ext
    end
    
    def scss? file
      ext? file, '.scss'
    end
    
    def js? file
      ext? file, '.js'
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
            file.chomp! ".scss";
            puts "[WebBlocks::Compiler scss] #{file}"
            scss.puts "@import \"#{file}\";"
          when js?(file)
            puts "[WebBlocks::Compiler js] #{file}"
            contents = File.read(file)
            js.puts contents
          end
        end
      end
      
      scss.close
      js.close
      
      puts "compass compile --sass-dir sass --css-dir ../#{@dst}/css" 
      sh "compass compile --sass-dir sass --css-dir ../#{@dst}/css" 
      
      FileUtils.rm_rf "tmp" if File.exists? "tmp";
      
      Dir.chdir pwd
      
    end
    
    def get_tree path
      
      contents = []
      
      contents.push path if File.file? path
      
      dir = File.dirname path
      Dir.entries(dir).each do |child|
        basename = File.basename path
        idx = child.index(basename);
        if idx == 0 && child[basename.length,1] == '.' || idx == 1 && child[0,1] == '_' && child[basename.length+1,1] == '.'
          contents.push "#{dir}/#{child}"
        end
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