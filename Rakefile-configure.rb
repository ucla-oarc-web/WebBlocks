# build settings

PACKAGES = [
 'jquery',
 'modernizr',
 'selectivizr',
 'bootstrap',
 'respond'
]
                   
DIR_BUILD       = 'build'
FILE_MAIN_CSS   = 'main.css'
FILE_MAIN_JS    = 'main.js'
FILE_IE_CSS     = 'ie.css'
FILE_IE_JS      = 'ie.js'

# specify the location of executables

CMD_GIT         = 'git'         # '"C:\Program Files (x86)\Git\bin\git.exe"'
CMD_GRUNT       = 'grunt'
CMD_NPM         = 'npm'
CMD_SASS        = 'sass'
CMD_UGLIFYCSS   = 'uglifycss'
CMD_UGLIFYJS    = 'uglifyjs'

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