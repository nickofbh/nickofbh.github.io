module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    less:
      all:
        options:
          yuicompress: true
          compress: true
        files:
          'dist/style.css': 'less/style.less'

    concat:
      options:
        separator: ';'
      all:
        src:
          [ "js/bootstrap.min.js"
            "js/index.js"
          ]
        dest:
          "dist/all.js"

    uglify:
      all:
        files:
          "dist/all.min.js": "dist/all.js"

    copy:
      res:
        files: [{expand: true, src: ['img/**/*'], dest: 'dist/', filter: 'isFile'},
                {expand: true, src: ['font/**/*'], dest: 'dist/', filter: 'isFile'}]
      php:
        files: [{expand: true, cwd:'src/', src: ['**/*.html'], dest: 'dist/', ext: '.html', filter: 'isFile'}]

    clean:
      js: ["dist/all.js"]
      res: ["dist/font", "dist/img"]

    watch:
      less:
        files: ['less/*.less', 'less/bootstrap/*.less']
        tasks: ['less:all']
      concat:
        files: ['js/*.js']
        tasks: ['concat:all', 'uglify:all', 'clean:js']
      copyres:
        files: ['font/**/*', 'img/**/*']
        tasks: ['clean:res', 'copy:res']
      copyphp:
        files: ['src/**/*.html']
        tasks: ['copy:php']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['clean', 'less', 'concat', 'uglify', 'clean:js', 'copy', 'watch']
