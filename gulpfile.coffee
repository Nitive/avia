gulp = require 'gulp'

# css
stylus = require 'gulp-stylus'
cmq = require 'gulp-combine-media-queries'
postcss = require 'gulp-postcss'
autoprefixer = require 'autoprefixer-core'
cssmin = require 'gulp-cssmin'
sourcemaps = require 'gulp-sourcemaps'
nib = require 'nib'

# utilities
notify = require 'gulp-notify'
plumber = require 'gulp-plumber'
gulpif = require 'gulp-if'
args = require('yargs').argv
sync = require 'browser-sync'

production = args.p or args.production or no

paths =
	html: './dest/*.html'
	stylus: './src/*.styl'
	deep_stylus: './src/**/*.styl'
	dest: './dest/'

gulp.task 'default', ['stylus']
gulp.task 'watch', ['browser-sync'], ->
	gulp.watch paths.deep_stylus, ['stylus']
	gulp.watch paths.html
		.on 'change', sync.reload

gulp.task 'stylus', ->
	gulp.src(paths.stylus)
		.pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
		.pipe gulpif not production, sourcemaps.init()
		.pipe stylus
			use: [nib()]
			'include css': true
			compress: production
			import: ['nib']
		.pipe gulpif production, cmq()
		.pipe postcss [ autoprefixer browsers: ['last 2 version', '> 1%'] ]
		.pipe gulpif production, cssmin()
		.pipe gulpif not production, sourcemaps.write()
		.pipe gulp.dest paths.dest
		.pipe sync.reload stream: true

gulp.task 'browser-sync', ->
	sync.init
		server:
			baseDir: paths.dest
