gulp = require 'gulp'
webserver = require 'gulp-webserver'

gulp.task 'serve', ->
    gulp.src 'public'
    .pipe webserver()

gulp.task 'default', ->
    gulp.src [
        'contents/index.html'
        'contents/**/*.html'
    ]
    .pipe gulp.dest 'public/'
