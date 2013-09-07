module.exports = (grunt) ->
  'use strict'

  # Underscore
  # ==========
  _ = grunt.util._

  # Package
  # =======
  pkg = require './package.json'

  # Configuration
  # =============

  # configuration = _(grunt.file.readYAML('./config.yml')).defaults
  #   server:
  #     host: null
  #     port: 80
  #     path: ''

  # server = configuration.server
  # configuration.address  = if server.host then "//#{server.host}" else ''
  # configuration.address += if server.host then ":#{server.port}" else ''

  # Grunt
  # =====

  grunt.initConfig

    # Cleanup
    # -------
    clean:
      build: 'build'
      temp: 'temp'
      bower: 'components'
      components: 'src/components'

    # Wrangling
    # ---------
    copy:
      options:
        excludeEmpty: true

      module:
        files: [
          dest: 'temp/scripts'
          cwd: 'temp/scripts-amd'
          expand: true
          src: [
            '**/*'
            '!main.js'
            '!vendor/**/*'
          ]
        ]

      static:
        files: [
          dest: 'temp'
          cwd: 'src'
          expand: true
          src: [
            '**/*'
            '!*.coffee'
            '!*.haml'
            '!*.scss'
            '!*.haml'
          ]
        ]

      build:
        files: [
          dest: 'build/'
          cwd: 'temp'
          expand: true
          src: [
            '**/*.{html,txt,png}',
            'fonts/**/*',
            'images/**/*',
          ]
        ]

    # Dependency management
    # ---------------------
    bower:
      install:
        options:
          targetDir: './src/components'
          cleanup: true
          install: true

    # Compilation
    # -----------
    coffee:
      compile:
        options:
          bare: true

        files: [
          expand: true
          cwd: 'src/scripts'
          src: '**/*.coffee'
          dest: 'temp/scripts'
          ext: '.js'
        ]

    # Micro-templating language
    # -------------------------
    haml:
      options:
        uglify: true
        placement: 'amd'
        language: 'coffee'
        customHtmlEscape: 'haml.escape'
        customPreserve: 'haml.preserve'
        customCleanValue: 'haml.clean'
        dependencies:
          'haml': 'lib/haml'

      compile:
        files: [
          dest: 'temp/templates/'
          cwd: 'src/templates'
          ext: '.js'
          expand: true
          src: '**/*.haml'
        ]

        options:
          target: 'js'

      index:
        files:
          'temp/index.html': 'src/index.haml'

    # Stylesheet Compressor
    # ---------------------
    mincss:
      compress:
        files:
          'build/styles/main.css': 'build/styles/main.css'

    # Stylesheet Preprocessor
    # -----------------------
    compass:
      options:
        sassDir: 'src/styles'
        imagesDir: 'src/images'
        cssDir: 'temp/styles'
        javascriptsDir: 'temp/scripts'
        force: true
        relativeAssets: true

      compile:
        options:
          outputStyle: 'expanded'
          environment: 'development'

      build:
        options:
          outputStyle: 'compressed'
          environment: 'production'

    # Module conversion
    # -----------------
    urequire:
      convert:
        template: 'AMD'
        bundlePath: 'temp/scripts/'
        outputPath: 'temp/scripts-amd/'

    # Script lint
    # -----------
    coffeelint:
      gruntfile: 'Gruntfile.coffee'
      src: [
        'src/**/*.coffee'
        '!src/scripts/vendor/**/*'
      ]

    # Webserver
    # ---------
    connect:
      options:
        port: 3502
        hostname: 'localhost'
        middleware: (connect, options) -> [
          require('connect-url-rewrite') ['^([^.]+|.*\\?{1}.*)$ /']
          connect.static options.base
          connect.directory options.base
        ]

      build:
        options:
          keepalive: true
          base: 'build'

      temp:
        options:
          base: 'temp'

    # Proxy
    # -----
    proxy:
      server:
        options:
          port: 3501
          router:
            'localhost/api/': 'localhost:8000/api/'
            'localhost': 'localhost:3502'

    # HTML Compressor
    # ---------------
    htmlmin:
      build:
        options:
          removeComments: true
          removeCommentsFromCDATA: true
          removeCDATASectionsFromCDATA: true
          collapseWhitespace: true
          collapseBooleanAttributes: true
          removeAttributeQuotes: true
          removeRedundantAttributes: true
          useShortDoctype: true
          removeEmptyAttributes: true
          removeOptionalTags: true

        files: [
          expand: true
          cwd: 'build'
          dest: 'build'
          src: '**/*.html'
        ]

    # Dependency tracing
    # ------------------
    requirejs:
      compile:
        options:
          out: 'build/scripts/main.js'
          include: _(grunt.file.expandMapping(['main*', 'controllers/**/*'], ''
            cwd: 'src/scripts/'
            rename: (base, path) -> path.replace /\.coffee$/, ''
          )).pluck 'dest'
          mainConfigFile: 'temp/scripts/main.js'
          baseUrl: './temp/scripts'
          keepBuildDir: true
          almond: true
          replaceRequireScript: [
            files: ['temp/index.html'],
            module: 'main'
          ]
          insertRequire: ['main']
          optimize: 'uglify2'

      css:
        options:
          out: 'build/styles/main.css'
          optimizeCss: 'standard.keepLines'
          cssImportIgnore: null
          cssIn: 'temp/styles/main.css'

    # Watch
    # -----
    watch:
      coffee:
        files: 'src/scripts/**/*.coffee'
        tasks: 'script'
        options:
          interrupt: true

      haml:
        files: 'src/templates/**/*.haml'
        tasks: 'haml:compile'
        options:
          interrupt: true

      index:
        files: 'src/index.haml'
        tasks: 'haml:index'
        options:
          interrupt: true

      compass:
        files: 'src/styles/**/*.scss'
        tasks: 'compass:compile'
        options:
          interrupt: true

  # Dependencies
  # ============
  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks name

  # Tasks
  # =====

  # Lint
  # ----
  # Lints all applicable files.
  grunt.registerTask 'lint', [
    'coffeelint'
  ]

  # Prepare
  # -------
  # Cleans the project directory of built files and downloads / updates
  # bower-managed dependencies.
  grunt.registerTask 'prepare', [
    'clean'
    'bower:install'
    'clean:bower'
  ]

  # Script
  # ------
  # Compiles all coffee-script into java-script converts them to the
  # appropriate module format (if neccessary).
  grunt.registerTask 'script', [
    'coffee:compile'
    'urequire:convert'
    'copy:module'
  ]

  # Server
  # ------
  # Compiles a development build of the application; starts an HTTP server
  # on the output; and, initiates a watcher to re-compile automatically.
  grunt.registerTask 'server', [
    'copy:static'
    'script'
    'haml:compile'
    'haml:index'
    'compass:compile'
    'connect:temp'
    'proxy'
    'watch'
  ]

  # Default
  # -------
  # The default grunt action
  grunt.registerTask 'default', [
    'prepare'
    'server'
  ]

  # Build
  # -----
  # Compiles a production build of the application.
  grunt.registerTask 'build', [
    'copy:static'
    'script'
    'haml:compile'
    'haml:index'
    'compass:build'
    'requirejs:compile'
    'copy:build'
    'requirejs:css'
    'mincss:compress'
    'htmlmin'
  ]
