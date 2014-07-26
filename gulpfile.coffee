gulp = require 'gulp'
webserver = require 'gulp-webserver'
marked = require 'marked'
fileinclude = require 'gulp-file-include'
coffee = require 'gulp-coffee'

gulp.task 'serve', ->
    gulp.src 'public'
    .pipe webserver {
        livereload: true
    }

gulp.task 'default', ->
    gulp.src [
            'contents/index.html'
        ].concat ["html","svg","js"].map (d) ->
            "contents/**/*.#{ d }"

        .pipe fileinclude
            filters :
                markdown: marked

        .pipe gulp.dest 'public/'

    gulp.src ['contents/**/*.coffee']
        .pipe coffee()
        .pipe gulp.dest 'public/'
