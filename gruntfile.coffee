'use strict'

module.exports = (grunt) ->

  # Utilities
  # =========
  path = require 'path'

  # Options
  # =======

  # Port offset
  # -----------
  # Increment this for additional gruntfiles that you want
  # to run simultaneously.
  portOffset = 8

  # Host
  # ----
  # You could set this to your IP address to expose it over a local internet.
  hostname = 'localhost'

  # Configuration
  # =============
  grunt.initConfig

    # Clean
    # -----
    # Configure 'grunt-contrib-clean' to remove all built and temporary
    # files.
    clean:
      bower: [
        'temp/bower_components'
      ]

      all: [
        'build'
        'temp'
      ]

    # Symlink
    # -------
    # Ensure that the temporary directories can access the bower components.
    symlink:
      bower:
        src: 'bower_components'
        dest: 'temp/bower_components'

    # Copy
    # ----
    # Ensure files go where they need to. Used for static files.
    copy:
      static:
        files: [
          expand: true
          filter: 'isFile'
          cwd: 'src'
          dest: 'temp'
          src: [
            '**/*'
            '!**/*.ls'
            '!**/*.scss'
            '!**/*.haml'
          ]
        ]

      build:
        files: [
          expand: true
          filter: 'isFile'
          dest: "build"
          cwd: "temp"
          src: [
            '*',
            'styles/**/*.css',
            'slides/**/*.html',
          ]
        ]

    # Script
    # ------
    coffee:
      compile:
        files: [
          expand: true
          filter: 'isFile'
          cwd: 'src'
          dest: 'temp'
          src: '**/*.coffee'
          ext: '.js'
        ]

        options:
          bare: true

    # Templates
    # ---------
    haml:
      compile:
        files: [
          expand: true
          filter: 'isFile'
          cwd: 'src'
          dest: 'temp'
          src: '**/*.haml'
          ext: '.html'
        ]

        options:
          target: 'html'
          language: 'coffee'
          uglify: true

    # Webserver
    # ---------
    connect:
      options:
        port: 5000 + portOffset
        hostname: hostname
        middleware: (connect, options) -> [
          require('connect-livereload')()
          connect.static options.base
        ]

      build:
        options:
          keepalive: true
          base: 'build'

      temp:
        options:
          base: 'temp'

    # Stylesheets
    # -----------
    sass:
      compile:
        dest: 'temp/styles/main.css'
        src: 'src/styles/main.scss'
        options:
          loadPath: path.join(path.resolve('.'), 'temp')

    # Watch
    # -----
    watch:
      bower:
        files: ['bower_components/**/*']
        tasks: ['symlink:bower']

      haml:
        files: ['src/**/*.haml']
        tasks: ['haml:compile']

      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee:compile']

      sass:
        files: ['src/**/*.scss']
        tasks: ['sass:compile']

      livereload:
        options: {livereload: true}
        files: ['temp/**/*']

    # Dependency tracing
    # ------------------
    requirejs:
      compile:
        options:
          out: "build/scripts/main.js"
          include: ['main']
          mainConfigFile: "temp/scripts/main.js"
          baseUrl: "temp/scripts"
          keepBuildDir: true
          cjsTranslate: true
          almond: true
          replaceRequireScript: [
            files: ["temp/index.html"],
            module: 'main'
          ]
          insertRequire: ['main']
          optimize: 'uglify2'

      css:
        options:
          out: "build/styles/main.css"
          optimizeCss: 'standard.keepLines'
          cssImportIgnore: null
          cssIn: "temp/styles/main.css"

    # CSS Compressor
    # --------------
    cssc:
      build:
        dest: "build/styles/main.css"
        src: "build/styles/main.css"
        options:
          sortSelectors: true
          lineBreaks: true
          sortDeclarations: true
          consolidateViaDeclarations: true
          consolidateViaSelectors: true
          consolidateMediaQueries: true
          compress: true
          sort: true
          safe: false

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

        src: "build/index.html"
        dest: "build/index.html"

    # Resource file hasher
    # --------------------
    hashres:
      options:
        fileNameFormat: '${name}-${hash}.${ext}'
        renameFiles: true

      build:
        src: [
          "build/styles/main.css"
          "build/scripts/main.js"
        ]

        dest: "build/index.html"

    # Filesize reporter
    # -----------------
    bytesize:
      all:
        files: [
          src: [
            "build/index.html",
            "build/styles/main*.css",
            "build/scripts/main*.js",
          ]
        ]

  # Dependencies
  # ============
  # Loads all grunt tasks from the installed NPM modules.
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # Tasks
  # =====

  # Default
  # -------
  # By default, the invocation 'grunt' should build and expose the
  # presentation at a default host/port.
  grunt.registerTask 'default', [
    'clean:all'
    'server'
  ]

  # Server
  # ------
  grunt.registerTask 'server', [
    'symlink:bower'
    'copy:static'
    'coffee:compile'
    'haml:compile'
    'sass:compile'
    'connect:temp'
    'watch'
  ]

  # Build
  # -----
  grunt.registerTask 'build', [
    'clean',
    'symlink:bower'
    'copy:static'
    'coffee:compile'
    'haml:compile'
    'sass:compile'
    'requirejs:compile'
    'copy:build'
    'requirejs:css'
    'cssc:build'
    'hashres'
    'htmlmin'
    'bytesize'
  ]
