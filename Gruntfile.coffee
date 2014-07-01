module.exports = (grunt) ->

  require("time-grunt") grunt
  require('load-grunt-tasks') grunt

  grunt.initConfig

    pkg: grunt.file.readJSON('./package.json')
    aws: grunt.file.readJSON('./aws-keys.json')

    sass:
      compile:
        options:
          style: 'compressed'
        files:
          'ebay-template-v2.css':'ebay-template-v2.scss'

    aws_s3:
      options:
        accessKeyId: '<%= aws.AWSAccessKeyId %>'
        secretAccessKey: '<%= aws.AWSSecretKey %>'
        uploadConcurrency: 5
        downloadConcurrency: 5

      ebay:
        options:
          bucket: 'optoro-ebay-rsrc'
          differential: true
        files: [
          {expand: true, cwd: './', src: ['*.css'], dest: 'ebay-template-v2'}
        ]

    watch:
      options:
        atBegin: true
        livereload: true

      sass:
        files: ['./**/*.scss']
        tasks: ['sass']

  grunt.registerTask 'default', ['watch']

  return
