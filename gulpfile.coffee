gulp     = require 'gulp'
coffee   = require 'gulp-coffee'
plumber  = require 'gulp-plumber'
stylus   = require 'gulp-stylus'
watchify = require 'gulp-watchify'
rename   = require 'gulp-rename'

watching = off

gulp.task 'enable-watch-mode', -> watching = on

gulp.task 'build:front', watchify (watchify) ->
  gulp.src 'public/src/coffee/main.coffee'
    .pipe plumber()
    .pipe watchify
      watch     : watching
      extensions: ['.coffee', '.js', '.cjsx']
    .pipe rename
      extname: ".js"
    .pipe gulp.dest 'public/dist'


gulp.task 'build:server', ->
  gulp.src ['*.coffee', '*/*.coffee', '*/*/*.coffee', '!gulpfile.coffee']
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest ''

gulp.task 'build:stylus', ->
  gulp.src 'public/styl/main.styl'
    .pipe plumber()
    .pipe stylus
      compress: true
    .pipe gulp.dest 'public/stylesheets'

gulp.task 'watch', ['enable-watch-mode', 'build:front'], ->
  gulp.watch ['*.coffee', '*/*.coffee'], ['build:server']
  gulp.watch ['public/styl/*.styl'], ['build:stylus']

gulp.task 'default', ['build:server']
