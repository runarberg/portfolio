gulp = require 'gulp'
autoprefix = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
fileinclude = require 'gulp-file-include'
less = require 'gulp-less'

md = require('markdown-it')()

gulp.task 'articles', ->
    gulp.src [
            'contents/index.html',
            'contents/**/*.{html,svg,js,geojson}'
        ]
        .pipe fileinclude
            filters :
                markdown: (str) ->
                    md.render str
        .pipe gulp.dest 'public/'

gulp.task 'coffee', ->
    gulp.src ['contents/**/*.coffee']
        .pipe coffee()
        .pipe gulp.dest 'public/'

gulp.task 'img', ->
    gulp.src ['contents/**/*.{png,jpeg}']
        .pipe gulp.dest 'public'

gulp.task 'fonts', ->
    gulp.src ['assets/fonts/*']
        .pipe gulp.dest 'public/assets/fonts/'

gulp.task 'less', ['fonts'], ->
    gulp.src ['styles/**/*.less',
              'contents/**/*.less']
        .pipe less()
        .pipe autoprefix()
        .pipe gulp.dest 'public/'

gulp.task 'watch', ['default'], ->
    livereload.listen()
    gulp.watch 'contents/**/*.{jpeg,png}', ['img']
    gulp.watch 'contents/**/*.{html,md,svg,geojson}', ['articles']
    gulp.watch 'contents/**/*.coffee', ['coffee']
    gulp.watch 'styles/**/*.less', ['less']
    gulp.watch 'contents/**/*.less', ['less']
    gulp.watch('public/**').on 'change', ->
        setTimeout livereload.changed, 200

    return

gulp.task 'default', ['coffee', 'less', 'articles', 'img']
