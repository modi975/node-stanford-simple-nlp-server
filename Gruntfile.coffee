path = require 'path'


module.exports = (grunt) ->
  for key of grunt.file.readJSON('package.json').devDependencies
    if key isnt 'grunt' and key.indexOf('grunt') is 0
      grunt.loadNpmTasks key
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    express:
      options:
        port: 20010
        hostname: '*'
        cmd: 'coffee'
      dev:
        options:
          script: 'server/index.coffee'
          node_env: 'dev'
      dist:
        options:
          script: 'server/index.coffee'
          node_env: 'dist'
          background: false

    open:
      server:
        url: 'http://localhost:<%= express.options.port %>'

    watch:
      dev_server:
        files: [ 'server/**/*' ]
        tasks: [ 'express:dev:stop', 'express:dev' ]
        options:
          spawn: false


  grunt.registerTask 'default', []

  grunt.registerTask 'server', [
    'server:dev'
  ]

  grunt.registerTask 'server:dev', [
    'express:dev'
    'open'
    'watch'
  ]
  
  grunt.registerTask 'server:dist', [
    'express:dist'
  ]
