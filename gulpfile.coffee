gulp = require 'gulp'
webserver = require 'gulp-webserver'
marked = require 'marked'
fileinclude = require 'gulp-file-include'

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
    .pipe fileinclude
        filters :
            markdown: marked
    .pipe gulp.dest 'public/'
