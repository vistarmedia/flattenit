coffee  = require 'gulp-coffee'
gulp    = require 'gulp'
mocha   = require 'gulp-mocha'


gulp.task 'default', ->
  gulp.src(['./src/**/*.coffee', ])
    .pipe(coffee(bare: true))
    .pipe(gulp.dest('./build'))


gulp.task 'test', ['default'], ->
  gulp.src('./test/**/*_spec.coffee')
    .pipe(mocha())
