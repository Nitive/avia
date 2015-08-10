gulp = require 'gulp'

jade = require 'gulp-jade'
data = require 'gulp-data'

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
path = require 'path'
fs = require 'fs'

production = args.p or args.production or no

paths =
	jade: './src/*.jade'
	json: './src/*.json'
	stylus: './src/*.styl'
	deep_stylus: './src/**/*.styl'
	dest: './dest/'

gulp.task 'default', ['jade', 'stylus']
gulp.task 'watch', ['browser-sync'], ->
	gulp.watch paths.deep_stylus, ['stylus']
	gulp.watch paths.jade, ['jade']
	gulp.watch paths.json, ['jade']


gulp.task 'stylus', ->
	gulp.src(paths.stylus)
		.pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
		.pipe gulpif not production, sourcemaps.init()
		.pipe stylus
			use: [nib()]
			'include css': true
			include: ['node_modules/']
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

gulp.task 'jade', ->
	gulp.src paths.jade
		.pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
		.pipe data (file) ->
			JSON.parse fs.readFileSync "./src/#{path.basename(file.path).replace /\.jade$/, '.json'}", 'utf8'
		.pipe jade()
		.pipe gulp.dest './dest/'
		.pipe sync.reload stream: true
