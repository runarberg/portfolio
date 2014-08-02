gulp = require 'gulp'
webserver = require 'gulp-webserver'
fileinclude = require 'gulp-file-include'
coffee = require 'gulp-coffee'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
marked = require 'marked'
Q = require 'q'

gulp.task 'serve', ->
    gulp.src 'public'
    .pipe webserver {
        livereload: true
    }

gulp.task 'articles', ->
    gulp.src [
            'contents/index.html',
            'contents/**/*.{html,svg,js}'
        ]
        .pipe fileinclude
            filters :
                markdown: marked
        .pipe gulp.dest 'public/'

gulp.task 'coffee', ->
    gulp.src ['contents/**/*.coffee']
        .pipe coffee()
        .pipe gulp.dest 'public/'

gulp.task 'watch', ->
    gulp.watch 'contents/**/*.{html,md,svg}', ['articles']
    gulp.watch 'contents/**/*.coffee', ['coffee']

gulp.task 'default', ['coffee', 'articles']
