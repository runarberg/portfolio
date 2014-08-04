gulp = require 'gulp'
autoprefix = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
fileinclude = require 'gulp-file-include'
less = require 'gulp-less'
webserver = require 'gulp-webserver'

marked = require 'marked'
myMarked = (src) ->
    marked(src).replace(/@@include\(&quot;(.+)&quot;\)/, '@@include("$1")')

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
                markdown: myMarked
        .pipe gulp.dest 'public/'

gulp.task 'coffee', ->
    gulp.src ['contents/**/*.coffee']
        .pipe coffee()
        .pipe gulp.dest 'public/'

gulp.task 'fonts', ->
    gulp.src ['assets/fonts/*.{otf,ttf}']
        .pipe gulp.dest 'public/assets/fonts/'

gulp.task 'less', ['fonts'], ->
    gulp.src ['styles/**/*.less',
              'contents/**/*.less']
        .pipe less()
        .pipe autoprefix()
        .pipe gulp.dest 'public/'

gulp.task 'watch', ['default'], ->
    gulp.watch 'contents/**/*.{html,md,svg}', ['articles']
    gulp.watch 'contents/**/*.coffee', ['coffee']
    gulp.watch 'styles/**/*.less', ['less']
    gulp.watch 'contents/**/*.less', ['less']

gulp.task 'default', ['coffee', 'less', 'articles']
