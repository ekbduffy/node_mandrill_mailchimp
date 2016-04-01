var gulp = require('gulp');
var server = require('gulp-express');


gulp.task('server', function () {
    
    server.run(['server.js']);
    gulp.watch(['views/*.swig'], [server.run,console.log]).on('change', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});;
    gulp.watch(['views/**/*.swig'], [server.run]).on('change', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});;
    gulp.watch(['server.js', 'controllers/*.js'], [server.run]).on('change', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});;
});

gulp.task('default', ['server']);