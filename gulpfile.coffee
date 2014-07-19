gulp = require 'gulp'
webserver = require 'gulp-webserver'

gulp.task 'serve', ->
    gulp.src 'public'
    .pipe webserver {
        livereload: true
    }

gulp.task 'default', ->
    gulp.src [
        'contents/index.html'
        'contents/**/*.html'
        'contents/**/*.svg'
    ]
    .pipe gulp.dest 'public/'
