# build settings

PACKAGES = [
 'bootstrap',
 'jquery',
 'modernizr',
 'respond',
 'selectivizr'
]
                   
DIR_BUILD       = 'build'
DIR_BUILD_CSS   = 'css'
DIR_BUILD_JS    = 'js'
DIR_BUILD_IMG   = 'img'
DIR_SRC         = 'src'
FILE_MAIN_CSS   = 'blocks.css'
FILE_MAIN_JS    = 'blocks.js'
FILE_IE_CSS     = 'blocks-ie.css'
FILE_IE_JS      = 'blocks-ie.js'

# specify the location of executables

CMD_GIT         = 'git'         # '"C:\Program Files (x86)\Git\bin\git.exe"'
CMD_GRUNT       = 'grunt'
CMD_NPM         = 'npm'
CMD_SASS        = 'sass'
CMD_UGLIFYCSS   = 'uglifycss'
CMD_UGLIFYJS    = 'uglifyjs'
CMD_COMPASS     = 'compass'

# package locations

DIR_PACKAGE     = 'package'
DIR_PACKAGES    = {
  'bootstrap' => 'sass-twitter-bootstrap',
  'jquery' => 'jquery',
  'modernizr' => 'modernizr',
  'respond' => 'respond',
  'selectivizr' => 'selectivizr',
}

# package settings

PACKAGE_BOOTSTRAP_SCRIPTS = [
  'dropdown',
  'button',
  'collapse',
  'alert'
]

# advanced configuration

DIR_BUILD_TMP   = '.build-tmp'
DIR_METADATA    = '.blocks'