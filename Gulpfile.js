var gulp = require('gulp');
var notify = require('gulp-notify');
var rename = require('gulp-rename');
var plumber = require('gulp-plumber');
var livereload = require('gulp-livereload');
var browserify = require('browserify');
var cachingCoffeeify = require('caching-coffeeify');
var coffeeReactify = require('coffee-reactify');
var transform = require('vinyl-transform');
var xtend = require('xtend');
var del = require('del');

var paths = {
  entry: './src/index.coffee',
  scripts: './src/**/*.coffee',
  views: './src/**/*.cjsx',
  output: './dist'
};

var reloader = null;

var getBundleName = function () {
  var name = require('./package.json').name;
  return name + '.js';
};

var coffeeReact = function(defaults){
  return function(file, opts){
    return coffeeReactify(file, xtend({}, defaults, opts));
  };
};

var coffeeBrowserify = function(standalone){
  return transform(function(filename){
    var b = browserify(filename, {
      extensions: ['.coffee', '.cjsx'],
      paths: ['.'],
      standalone: standalone || null
    });
    b.transform(coffeeReact({coffeeout:true}))
    b.transform(cachingCoffeeify)
    return b.bundle()
      .on('error', coffeeError);
  });
};

var coffeeError = function(error){
  notify.onError({
    title: "Build error",
    message: error.toString()
  })(error);
  this.emit('end');
}

gulp.task('clean', function(cb) {
  del([paths.output], cb);
});

gulp.task('build', function() {
  
  var stream = gulp.src(paths.entry)
    .pipe(plumber())
    .pipe(coffeeBrowserify("SimpleGalleryFlux"))
    .pipe(rename(getBundleName()))
    .pipe(gulp.dest(paths.output));
  
  if(reloader){
    stream.on('end', livereload.changed);
  }
  
  return stream;
  
});

gulp.task('watch', function() {
  
  reloader = livereload.listen();
  
  gulp.watch([paths.entry, paths.scripts, paths.views], ['build']);
  
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['build', 'watch']);
