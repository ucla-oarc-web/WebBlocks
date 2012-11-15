#
# Compass configuration file
#
# Default settings are likely sufficient
# 

require 'pathname'
rootdir = File.dirname(File.dirname(File.dirname(Pathname.new(__FILE__).realpath)))

additional_import_paths = ["#{rootdir}/package", "sass"]

http_path = "/"
css_dir = "css/compiled"
images_dir = "img"
fonts_dir = "fonts"
javascripts_dir = "js"
relative_assets = true

output_style = (environment == :production) ? :compressed : :compact
line_comments = environment != :production