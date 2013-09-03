matchdep = require 'matchdep'

module.exports = (grunt) ->
  grunt.initConfig

    clean:
      dist: ['dist']

    coffee:
      compile:
        options:
          sourceMap: true
        files:
          'dist/angular-linkto.js': 'src/**/*.coffee'

    ngmin:
      all:
        src: [ 'dist/angular-linkto.js' ]
        dest: 'dist/angular-linkto.js'

    uglify:
      options:
        mangle: true
        compress: true
      app:
        files:
          'dist/angular-linkto.js': [ 'dist/angular-linkto.js' ]

  matchdep.filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.registerTask 'dist', [ 'clean', 'coffee', 'ngmin', 'uglify' ]