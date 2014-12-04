module.exports = (grunt) ->
  grunt.initConfig {

    # compile coffeescript files
    coffee:
      pickadate:
        files:
          'knockout-pickadate.js': 'knockout-pickadate.coffee'

    # uglifyjs files
    uglify:
      pickadate:
        src: 'knockout-pickadate.js'
        dest: 'knockout-pickadate.min.js'
  }

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask('default', [
    'coffee',
    'uglify'
  ])
